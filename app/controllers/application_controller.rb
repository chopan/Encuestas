class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_usuario_session, :current_usuario, :encuesta_propia?

 protected
  def current_usuario_session
    @current_usuario_session ||= UsuarioSession.find
  end

  def current_usuario
    @current_usuario ||= current_usuario_session && current_usuario_session.usuario
  end

  def authenticate
    unless current_usuario_session
     
      redirect_to new_usuario_session_path
      return false
    end
  end

  def administrador?
    unless current_usuario_session and current_usuario.is_admin?
      flash[:notice] = "Necesita ser administrador"
      redirect_to root_path
    end
  end

  def encuesta_propia?(encuesta)
    encuesta.creador == current_usuario or current_usuario.is_admin?
  end
end
