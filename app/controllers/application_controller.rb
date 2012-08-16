class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_usuario_session, :current_usuario, :encuesta_propia?, :encuestado_contesto_encuesta?

 protected
  def current_usuario_session
    @current_usuario_session ||= UsuarioSession.find
  end

  def current_usuario
    @current_usuario ||= current_usuario_session && current_usuario_session.usuario
  end

  def authenticate
    unless current_usuario_session
      flash[:error] = "Necesitas iniciar sesion"
      redirect_to new_usuario_session_path
      return false
    else
      if current_usuario.is_encuestado?
        flash[:error] = "Permisos insuficientes"
        current_usuario_session.destroy
        redirect_to new_usuario_session_path
        return false
      end
    end
  end

  def administrador?
    unless current_usuario_session and current_usuario.is_admin?
      flash[:error] = "Necesita ser administrador" unless request.url == root_url
      redirect_to encuestas_url
    end
  end

  #Los encuestados aun siendo anonimos son guardados para poder identificar si el usuario
  #ya ha contestado la encuesta o no

  def encuestado_actual
    session_id = request.session_options[:id]
    encuestado = Encuestado.find_by_session_id(session_id) || Encuestado.new(:session_id => session_id)
  end

  def encuestado_contesto_encuesta?(encuestado,encuesta)
    pregunta = encuesta.preguntas.first
    Respuesta.where(:pregunta_id => pregunta, :encuestado_id => encuestado).first ? true : false
  end

end
