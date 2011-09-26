class EncuestasController < ApplicationController

 def index
   @encuestas = Encuesta.all
   puts 555555
   puts request.cookies
   
 end

def new
  @encuesta = Encuesta.new
  3.times do
    pregunta = @encuesta.preguntas.build
    3.times { pregunta.opciones.build }
  end
end

def create
  @encuesta = Encuesta.new(params[:encuesta])
  @encuesta.creador = current_usuario
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

def destroy
    @encuesta = Encuesta.find(params[:id])
    if encuesta_propia?(@encuesta) or current_usuario.is_admin?
      @encuesta.destroy
      respond_to do |format|
          format.html { redirect_to encuestas_url }
          format.json { head :ok }
    end
    else
      flash[:notice] = "Solo puedes eliminar tus propias encuestas"
      redirect_to encuestas_url
    end
end

def contestar
    @encuesta = Encuesta.find(params[:id])
end

def capturar_datos
 estado = true
 sesion_id = request.session[:session_id]
 params[:encuesta].values.each do |opcion_id|
   respuesta = Respuesta.new
   opcion = Opcion.find(opcion_id)
   respuesta.encuestado_id = 1
   respuesta.pregunta_id = opcion.pregunta.id
   respuesta.opcion_id = opcion.id
   unless respuesta.save
      estado = false
      break
   end
 end
 if estado
   flash[:notice] = "Datos guardados"
   redirect_to encuestas_url
 else
   render 'contestar'
 end
  
end

  def grafica_resultados
    
  end
end
