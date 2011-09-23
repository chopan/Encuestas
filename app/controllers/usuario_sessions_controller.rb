class UsuarioSessionsController < ApplicationController
before_filter :authenticate, :only => :destroy

  def new
    @usuario_session = UsuarioSession.new
  end

  def create
    @usuario_session = UsuarioSession.new(params[:usuario_session])

    if @usuario_session.save
      redirect_to root_path
    else
      render :action => :new
    end
  end


  def destroy
    current_usuario_session.destroy
    redirect_to new_usuario_session_path
  end

end
