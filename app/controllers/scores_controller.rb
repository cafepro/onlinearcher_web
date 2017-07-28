class ScoresController < ApplicationController
  layout 'app'
  before_action :authenticate_user!
  before_action :set_score, only: [:show, :edit, :update, :destroy, :puntuar, :add_arrows]

  def puntuar
    @arrows = @score.arrows
  end

  def add_arrows
    params[:arrow].each_pair do |param,arrow|
      value = Arrow.get_arrow_value(arrow)
      Arrow.create(score_id: @score.id, value: value, arrow: arrow)
      # acutalizamos datos del score
      @score.points += value
      @score.x_count += 1 if params[:arrow] == 'X'
      @score.ten_count += 1 if value == 10
      @score.nine_count += 1 if value == 9
      @score.average = (@score.points.to_f / @score.arrows.count.to_f).to_f.round(2)
      @score.save
    end
  end

  # GET /scores
  # GET /scores.json
  def index
    @scores = Score.all
  end

  # GET /scores/1
  # GET /scores/1.json
  def show
  end

  # GET /scores/new
  def new
    @score = Score.new()
  end

  # GET /scores/1/edit
  def edit
  end

  # POST /scores
  # POST /scores.json
  def create
    @score = Score.new(score_params)
    @score.user_id = current_user.id
    respond_to do |format|
      if @score.save
        format.html { redirect_to puntuar_score_path(@score) }
        format.json { render :show, status: :created, location: @score }
      else
        format.html { render :new }
        format.json { render json: @score.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /scores/1
  # PATCH/PUT /scores/1.json
  def update
    respond_to do |format|
      if @score.update(score_params)
        format.html { redirect_to @score, notice: 'Score was successfully updated.' }
        format.json { render :show, status: :ok, location: @score }
      else
        format.html { render :edit }
        format.json { render json: @score.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /scores/1
  # DELETE /scores/1.json
  def destroy
    @score.destroy
    respond_to do |format|
      format.html { redirect_to scores_url, notice: 'Score was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_score
      @score = Score.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def score_params
      params.require(:score).permit(:name, :score_type_id, :user_id, :state, :published, :points, :average, :x_count, :ten_count, :nine_count)
    end
end
