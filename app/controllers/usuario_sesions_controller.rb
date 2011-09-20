class UsuarioSesionsController < ApplicationController
before_filter :authenticate, :only => :destroy

  def new
    @usuario_session = UsuarioSesion.new
  end

  def create
    @usuario_session = UsuarioSesion.new(params[:user_session])

    if @usuario_sesion.save
      redirect_to root_path
    else
      render :action => :new
    end
  end


  def destroy
    current_usuario_session.destroy
    redirect_to new_usuario_sesion_path
  end

end
