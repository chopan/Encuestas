class EncuestasController < ApplicationController
before_filter :authenticate

 def index
   @encuestas = Encuesta.all
   
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
  @encuesta.concurrencia = 0
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
   @encuesta_id = opcion.pregunta.encuesta.id
   respuesta.encuestado_id = 1
   respuesta.pregunta_id = opcion.pregunta.id
   respuesta.opcion_id = opcion.id
   unless respuesta.save
      estado = false
      break
   end
 end
 if estado
   @encuesta = Encuesta.find(@encuesta_id)
   flash[:notice] = "Datos guardados"
   puts
   @encuesta.concurrencia = @encuesta.concurrencia + 1
   @encuesta.save
   redirect_to grafica_resultados_url(@encuesta_id)
 else
   render 'contestar'
 end
  
end

  def grafica_resultados
    @encuesta = Encuesta.find(params[:id])

  end
end
