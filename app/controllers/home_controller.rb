class HomeController < ApplicationController

	respond_to :html

	before_action :set_header

	def index

	end

	private
		def set_header
			@header = Header.find_by_used_at('HomeController')
		end
end