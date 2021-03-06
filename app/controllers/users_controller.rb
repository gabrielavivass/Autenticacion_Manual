class UsersController < ApplicationController
  before_action :set_user, only: [:show]

    def show
      @user = User.find(params[:id])
      @user = User.includes(:stories).find(helpers.current_user.id)
    end
  
    # GET /user/new
    def new
      @user = User.new
    end

    def edit
    end

    def create
      @user = User.new(user_params)
      respond_to do |format|
          if @user.save
              session[:user_id] = @user.id 
              format.html { redirect_to root_path, notice: 'User was successfully created.' }
          else
              format.html { render :new }
          end
      end
    end

    private

    def set_user
      @user = User.find(params[:id])
    end
    
    def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end


end