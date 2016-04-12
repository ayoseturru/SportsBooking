class SessionsController < ApplicationController

  def create
    if user=User.authenticate(params[:dni], params[:password])
      session[:user_id] =user.id
      redirect_to bookings_path, notice:"Login successfully"
    else
      flash.now[:alert] = "Invalid credentials"
      render action: :new
    end
  end

  def destroy
    reset_session
    redirect_to action: :new, notice: "Logout successfully"
  end

  def welcome

  end
end
