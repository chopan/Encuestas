class EncuestasController < ApplicationController

 def index
   @encuestas = Encuesta.all
 end

def new
  @encuesta = Encuesta.new
  3.times do
    pregunta = @encuesta.preguntas.build
    3.times { pregunta.respuestas.build }
  end
end

def create
  @encuesta = Encuesta.new(params[:encuesta])
  @encuesta.preguntas.each do |pregunta|
      pregunta.encuesta_id = @encuesta.id
  end
  if @encuesta.save
    flash[:notice] = "Encuesta guardada correctamente"
    redirect_to encuestas_path
  else
    render 'new'
  end
end
end
