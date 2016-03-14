class SessionsController < ApplicationController
  def create
    if user=User.authenticate(params[:dni], params[:password])
      session[:user_id] =user.id
      redirect_to root_path, notice:"login Correcto"
    else
      flash.now[:alert] = "Parametros incorrectos"
      render action: :new
    end
  end
  def destroy
    reset_session
    redirect_to root_path, notice: "Te has logueado correctamente"
  end
end
