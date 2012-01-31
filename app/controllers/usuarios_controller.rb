class UsuariosController < ApplicationController
 # before_filter :authenticate
  #before_filter :administrador?, :only => [:destroy]
  def index
    @usuarios = Usuario.all
  end

  def show
    @usuario = Usuario.find(params[:id])
  end

  def new
    @usuario = Usuario.new
  end

  def create
    @usuario = Usuario.new(params[:usuario])
    if params[:admin] == "1"
      @usuario.add_role 'admin'
    end
    if @usuario.save
      redirect_to @usuario
    else
      render 'new'
    end
  end

  def edit
    @usuario = Usuario.find(params[:id])
  end

  def update
    @usuario = Usuario.find(params[:id])
    respond_to do |format|
      if @usuario.update_attributes(params[:usuario])
        format.html { redirect_to @usuario, :notice=> 'Usuario actualizado correctamente.' }
        format.json { head :ok }
      else
        format.html { render :action=> "edit" }
        format.json { render json=> @user.errors, status=> :unprocessable_entity }
      end
    end
  end
end
