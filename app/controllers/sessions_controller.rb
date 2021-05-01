class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.find_by_email(params[:email])
    if @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to root_path, notice: "Log In is successfully"
    else
      flash.now[:notice] = 'User or Password Invalid'
      render action: :new
    end
  end

  def destroy
    reset_session
    redirect_to root_path, notice: 'Signed Out successfully'
  end
end