# encoding: UTF-8
require 'will_paginate/array'
class EncuestasController < ApplicationController
  before_filter :authenticate, :except => [:contestar, :gracias, :capturar_datos]
  before_filter :encuesta_propia?, :only => [:show, :edit]

 def index
   @encuestas = (Encuesta.find_all_by_creador_id current_usuario.id).paginate(:page => params[:page], :per_page => 15)
 end

def new
  @encuesta = Encuesta.new
  #Pone por default el numero de preguntas que aparece al crear una nueva encuesta
    3.times do
      pregunta = @encuesta.preguntas.build
      pregunta.opciones.build
    end
end

def create
  @encuesta = Encuesta.new(params[:encuesta])
  @encuesta.creador = current_usuario
  @encuesta.concurrencia = 0
  @encuesta.preguntas.each do |pregunta|
      pregunta.encuesta_id = @encuesta.id
      pregunta.save
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
 #Para las preguntas de una sola opcion
 contador_simples = 0
 contador_multiples = 0
 if params[:encuesta] != nil and estado
   params[:encuesta].values.each do |opcion_id|
     opcion = Opcion.find(opcion_id)
     estado = crear_respuesta opcion
     contador_simples += 1
   end
 end
 params.each do |param|
   #Para las preguntas de opcion multiple
    if /^[\d]+(\.[\d]+){0,1}$/ === param[0] and param[1] == "1"
      opcion = Opcion.find(param[0])
      estado = crear_respuesta opcion, param
      contador_multiples += 1
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
 
 if estado and contador_simples > 0 and contador_multiples > 0
   @encuesta = Encuesta.find(@encuesta_id)
   flash[:notice] = "Datos guardados"
    @encuesta.concurrencia = @encuesta.obtener_concurrencia
    @encuesta.save
    redirect_to encuesta_gracias_url
   else
     
     flash[:error]= "Llene todos los campos porfavor"
     redirect_to contestar_encuesta_url @encuesta_id
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
end
