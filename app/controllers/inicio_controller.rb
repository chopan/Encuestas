# encoding: UTF-8
class InicioController < ApplicationController
  before_filter :authenticate
  before_filter :administrador?
	def index
    @encuestas = Encuesta.order("id DESC").limit 5
	end
end
