# encoding: UTF-8
class EncuestasController < ApplicationController


 def index
   @encuestas = Encuesta.all
   
 end

def new
  @encuesta = Encuesta.new
  1.times do
    pregunta = @encuesta.preguntas.build
    1.times { pregunta.opciones.build }
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
    respond_to do |format|
      format.html 
    end
end

def capturar_datos
  @encuestado = encuestado_actual
  if @encuestado.new_record?
    @encuestado.save
  end



 estado = true
 sesion_id = request.session[:session_id]
 params.each do |param|
    if /^[\d]+(\.[\d]+){0,1}$/ === param[0] and param[1] == "1"
      opcion = Opcion.find(param[0])
      estado = crear_respuesta opcion, param
    else
      if /^[\d]+(\.[\d]+){0,1}$/ === param[0]
          opcion = Opcion.find(param[0])
         
          if opcion.pregunta.pregunta_tipo.nombre == "Abierta"

            estado = crear_respuesta opcion, param
          
          end
      end
      
    end
 end
 if params[:encuesta] != nil
   params[:encuesta].values.each do |opcion_id|
     opcion = Opcion.find(opcion_id)
     estado = crear_respuesta opcion
   end
 end
 if estado
   @encuesta = Encuesta.find(@encuesta_id)
   flash[:notice] = "Datos guardados"
    @encuesta.concurrencia = @encuesta.obtener_concurrencia
    @encuesta.save
    redirect_to grafica_resultados_url(@encuesta_id)
   else
    render 'contestar'
   end
  
  end

  def grafica_resultados
    @encuesta = Encuesta.find(params[:id])

  end

  def prueba
    @encuesta = Encuesta.find(16)
    respond_to do |format|
      format.html do
        puts "////////////////// }"
        render 'contestar'
      end
    end
  end

 private
  def crear_respuesta(*args)
    estado = true
    respuesta = Respuesta.new
     @encuesta_id = args[0].pregunta.encuesta.id
     respuesta.encuestado_id = @encuestado.id
     respuesta.pregunta_id = args[0].pregunta.id
     respuesta.opcion_id = args[0].id
    if args.size > 1
      respuesta.texto = args[1][1]
    end
    unless respuesta.save
      estado = false
    end
     estado
  end
end
