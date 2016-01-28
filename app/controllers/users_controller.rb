class UsersController < ApplicationController
  before_filter :find_user, :only => [:show, :edit, :update, :destroy] #viene eseguito sempre find_user in tutte le azioni :only

  def index
    @users = User.all
  end

  def new
    @user = User.new #<User id: nil, name: nil, email: nil, created at: nil, updated at: nil>
  end

  def create
    @user = User.new(params[:user]) #non c'è la gemma strong_parameter quindi non è possibile fare con user_params da definire
                                    #nel private def user_params params.require(:user).permit(:name, :email) end (solo rails 4)                             
    if @user.save
      flash[:notice] = "User successfully created"
      redirect_to user_path(@user)
    else 
      render :new #oppure render "new"
    end    
  end

  def show  
    #@user = User.find(params[:id])
  end

  def edit
    #@user = User.find(params[:id])
  end

  def update
    #@user = User.find(params[:id])
    if @user.update_attributes(params[:user]) #in Rails 4 basterebbe @user.update(params[:user]), in alternativa reload
      flash[:notice] = "User successfully updated"
      redirect_to user_path(@user)
    else
      render :new
    end
  end

  def destroy
    #@user = User.find(params[:id])
    @user.destroy
    flash[:notice] = "User successfully destroyed"
    redirect_to users_path
  end

  private

  def find_user
    @user = User.find(params[:id])
  end
end