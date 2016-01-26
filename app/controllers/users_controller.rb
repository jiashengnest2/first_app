class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user]) #non c'è la gemma strong_parameter quindi non è possibile fare con user_params da definire
                                    #nel private def user_params params.require(:user).permit(:name, :email) end (solo rails 4)                             
    @user.save
    redirect_to user_path(@user)    
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(params[:user])
    redirect_to user_path(@user)
  end
end
