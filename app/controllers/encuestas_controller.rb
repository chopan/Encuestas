class EncuestasController < ApplicationController

def new
  @encuesta = Encuesta.new
  3.times do
    pregunta = @encuesta.pregunta.build
    3.times { preguntas.respuesta.build }
  end
end


end
