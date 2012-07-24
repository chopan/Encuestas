# encoding: UTF-8
require 'will_paginate/array'
class EncuestasController < ApplicationController
  before_filter :resultados_publicos?, :only => :grafica_resultados
  before_filter :authenticate, :except => [:contestar, :gracias, :capturar_datos, :grafica_resultados]
  before_filter :encuesta_propia?, :only => [:show, :edit]

 def index
   if current_usuario.is_admin?
     @encuestas = Encuesta.all.paginate(:page => params[:page], :per_page => 9)
   else
     @encuestas = (Encuesta.find_all_by_creador_id current_usuario.id).paginate(:page => params[:page], :per_page => 9)
   end
 end

def new
  @encuesta = Encuesta.new
  @encuesta.build_encabezado
  @encuesta.build_footer
  #Pone por default el numero de preguntas que aparece al crear una nueva encuesta
    3.times do
      pregunta = @encuesta.preguntas.build
      2.times  {pregunta.opciones.build
          puts pregunta
      }

    end
    @x = 0
    session[:po_index] = 2
end

def increment_po_id
  session[:po_index] = session[:po_index] + 1
  respond_to do |format|
    format.js 
  end
end

def set_po_id
  respond_to do |format|
    format.js 
  end
end

def create
  @encuesta = Encuesta.new(params[:encuesta])
  @encuesta.creador = current_usuario
  @encuesta.concurrencia = 0
  x = 0
  @encuesta.preguntas.each do |pregunta|
      pregunta.encuesta_id = @encuesta.id
      pregunta.save
      x = x +1
  end
  if @encuesta.save
    flash[:notice] = "Encuesta guardada correctamente"
    redirect_to encuesta_path(@encuesta)
  else
    @x = 0
    session[:po_index] = 2
    render 'new'
  end
end

def show
  @encuesta = Encuesta.find(params[:id])
end

def edit
  @encuesta = Encuesta.find(params[:id])
  @encuesta.build_encabezado
  @encuesta.build_footer
  @x = 0
end

def update
  @encuesta = Encuesta.find(params[:id])
  if @encuesta.update_attributes(params[:encuesta])
    flash[:notice] = "Encuesta editada correctamente"
    redirect_to encuesta_url(@encuesta)
  else
    @x = 0
    session[:po_index] = 2
    render 'edit'
  end
end

def destroy
    @encuesta = Encuesta.find(params[:id])
    if encuesta_propia?(@encuesta) or current_usuario.is_admin?
      @encuesta.destroy
      respond_to do |format|
          format.html { redirect_to resultados_url }
          format.json { head :ok }
    end
    else
      flash[:notice] = "Solo puedes eliminar tus propias encuestas"
      redirect_to encuestas_url
    end
end

def contestar
    @encuesta = Encuesta.find(params[:id])
    @preguntas = @encuesta.preguntas
    respond_to do |format|
      format.html 
    end
end

def capturar_datos
  @encuestado = encuestado_actual
  @encuesta = Encuesta.find params[:encuesta_id]
  if @encuestado.new_record?
    @encuestado.save
  end
  estado = true
 sesion_id = request.session[:session_id]



 #Aqui se lleva a cabo el proceso de validacion, se recorre arreglo de parametros para verificar que
 # todos los campos se llenaron correctamente. Se tiene un contador por cada tipo de pregunta
 contador_simples = 0
 contador_multiples = 0
 contador_abiertas = 0
  #Para las preguntas de una sola opcion
 if params[:encuesta] != nil and estado
   params[:encuesta].values.each do |opcion_id|
     contador_simples += 1
   end
 end
 params.each do |param|
   #Para las preguntas de opcion multiple
    if /^[\d]+(\.[\d]+){0,1}$/ === param[0] and param[1] == "1"
      contador_multiples += 1
    else
      #Para las preguntas abiertas
      if /^[\d]+(\.[\d]+){0,1}$/ === param[0] and param[1] != ""
          opcion = Opcion.find(param[0])
          if opcion.pregunta.pregunta_tipo.nombre == "Abierta"
            contador_abiertas += 1 unless opcion.pregunta.opcional == true
          end
      end
    end
 end

 no_simples = @encuesta.preguntas.where("pregunta_tipo_id = 1").count
 no_multiples = @encuesta.preguntas.where("pregunta_tipo_id = 2").count
 no_abiertas = 0
 @encuesta.preguntas.where("pregunta_tipo_id = 3").each do |pregunta|
   pregunta.opciones.each do
     no_abiertas += 1
   end
 end

  @encuesta.preguntas.where("pregunta_tipo_id = 3 and (opcional = ? OR opcional = ?)","true", true).each do |pregunta|
    contador_abiertas += 1
 end

 
 #Aqui se crean las respuestas, se lleva a cabo el mismo procedimiento que para la validacion, solo que aqui se
 #  se buscan opciones y se procesan esos datos, ademas de mandar llamar metodo para crear respuesta en base de datos
 if contador_simples == no_simples and contador_multiples >= no_multiples  and contador_abiertas == no_abiertas
 
     if params[:encuesta] != nil 
       params[:encuesta].values.each do |opcion_id|
         opcion = Opcion.find(opcion_id)
         crear_respuesta opcion
       end
     end
     params.each do |param|
       #Para las preguntas de opcion multiple
        if /^[\d]+(\.[\d]+){0,1}$/ === param[0] and param[1] == "1"
          opcion = Opcion.find(param[0])
          estado = crear_respuesta opcion, param
        else
          #Para las preguntas abiertas
          if /^[\d]+(\.[\d]+){0,1}$/ === param[0]
              opcion = Opcion.find(param[0])
              if opcion.pregunta.pregunta_tipo.nombre == "Abierta"
                estado = crear_respuesta opcion, param
              end
          end
        end
     end
  end

 if contador_simples == no_simples and no_multiples <= contador_multiples and contador_abiertas >= no_abiertas
   
   flash[:notice] = "Datos guardados"
    @encuesta.concurrencia = @encuesta.obtener_concurrencia
    @encuesta.save
    redirect_to encuesta_gracias_url
   else
     
     flash[:error]= "Llene todos los campos porfavor"
     redirect_to contestar_encuesta_url @encuesta.id
   end
  
  end

  def grafica_resultados
    @encuesta = Encuesta.find(params[:id])
    @preguntas = @encuesta.preguntas.where("pregunta_tipo_id != ?", 3).paginate(:page => params[:page], :per_page => 1)
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

  def preguntas_abiertas
    @encuesta_id = params[:id]
    @preguntas = Encuesta.find(params[:id]).preguntas.where("pregunta_tipo_id = ?", 3)
  end

  def opcion_respuestas
    @respuestas = Respuesta.find_all_by_opcion_id(params[:opcion_id]).paginate(:page => params[:page], :per_page => 20)
  end

  def gracias
    
  end

  def resultados
    if current_usuario.is_admin?
     @encuestas = Encuesta.all.paginate(:page => params[:page], :per_page => 11)
   else
     @encuestas = (Encuesta.find_all_by_creador_id current_usuario.id).paginate(:page => params[:page], :per_page => 11)
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

  def encuesta_propia?(*args)
    if args.size > 0
      encuesta = Encuesta.find(args[0])
    else
      encuesta = Encuesta.find(params[:id])
    end

  
    
    unless encuesta.creador == current_usuario or current_usuario.is_admin?
      flash[:error] = "No tiene los permisos para acceder a esta encuesta"
      redirect_to encuestas_url
    end
  end

  def resultados_publicos?
    @encuesta = Encuesta.find(params[:id])
    unless current_usuario_session 
      unless @encuesta.resultados_publicos
        flash[:error] = "No tiene los permisos para ver los resultados"
        render :inline => "<%= link_to 'Regresar a la encuesta', contestar_encuesta_url(#{@encuesta.id})%>", :layout => true
      end
    end
  end
end
