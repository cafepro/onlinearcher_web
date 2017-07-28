class HeadersController < ApplicationController

  before_action :authenticate_user!
  
  before_action :set_header, only: [:show, :edit, :update, :destroy]
  before_action :set_controllers, only: [:edit, :new]

  respond_to :html

  def index
    @headers = Header.all
    respond_with(@headers)
  end

  def show
    respond_with(@header)
  end

  def new
    @header = Header.new
    respond_with(@header)
  end

  def edit
  end

  def create
    @header = Header.new(header_params)
    @header.save
    respond_with(@header)
  end

  def update
    @header.update(header_params)
    respond_with(@header)
  end

  def destroy
    @header.destroy
    respond_with(@header)
  end

  private
    def set_controllers
      Rails.application.eager_load!
      @controllers = ApplicationController.descendants
    end
    
    def set_header
      @header = Header.find(params[:id])
    end

    def header_params
      params.require(:header).permit(:title, :description, :photo, :used_at)
    end
end
