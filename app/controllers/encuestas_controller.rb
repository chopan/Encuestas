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
    redirect_to encuesta_path(@encuesta)
  else
    render 'new'
  end
end

def show
  @encuesta = Encuesta.find(params[:id])
end

def edit
  @encuesta = Encuesta.find(params[:id])
end

def update
  @encuesta = Encuesta.find(params[:id])
  if @encuesta.update_attributes(params[:encuesta])
    flash[:notice] = "Encuesta editada correctamente"
    redirect_to encuesta_url(@encuesta)
  else
    render 'edit'
  end
end

end
