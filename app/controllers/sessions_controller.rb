class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.authenticate_with_credentials(params[:email], params[:password])
    if usersession[:user_id] = user.include
      redirect_to root_path, notice: 'Logged in successfully.'
    else
      redirect_to login_path, alert: 'Invalid email or password.'
    end
  end

  def destroy
    session[ :user_id ] = nil
    redirect_to '/login'
  end
end
