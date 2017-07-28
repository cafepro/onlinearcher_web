class Score < ActiveRecord::Base
	belongs_to :user
	belongs_to :score_type
	has_many   :arrows, dependent: :destroy
	validates :score_type, :name, :user_id, presence: true

	enum state: [:started, :ended, :deleted]

	before_create :do_create_tasks

	scope :published, -> { where(published: true) }

	private
		def do_create_tasks
			# marcar como comenzada
			self.state = Score.states[:started]
			# marcar como privada por defecto
			self.published = false
			# establecemos valores iniciales
			self.points = self.x_count = self.ten_count = self.nine_count = 0
    		self.average = 0.0
		end

	public

		def puntos_ronda_anterior
			return 0	
		end

		def parcial
			return 0
		end

end
