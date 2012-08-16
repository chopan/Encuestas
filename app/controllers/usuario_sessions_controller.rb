class UsuarioSessionsController < ApplicationController
before_filter :authenticate, :only => :destroy

  def new
    @usuario_session = UsuarioSession.new
  end

  def create

    u = Usuario.find_by_login(params[:usuario_session][:login])
    if u.nil?
      @user = Usuario.create(:login => params[:usuario_session][:login], :email => params[:usuario_session][:login] + "@uach.mx", :password => "123pum")
      @user.add_role "encuestado"
      @user.save
    end

    @usuario_session = UsuarioSession.new(params[:usuario_session])

    if @usuario_session.save
      redirect_back_or root_path
    else
      @user.delete
      render :action => :new
    end
  end


  def destroy
    current_usuario_session.destroy
    redirect_to new_usuario_session_path
  end

  private
  
    def redirect_back_or(default)
      redirect_to(session[:return_to] || default)
      session.delete(:return_to)
    end
end
