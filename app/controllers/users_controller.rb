class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:edit, :update, :index, :destroy]
  before_filter :correct_user, only: [:edit, :update]
  before_filter :admin_user, only: [:destroy]
  
  def new
    if signed_in?
      redirect_to root_path
    else
      @user = User.new
    end
  end
  
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end
  
  def create
    if signed_in?
      redirect_to root_path
    else
      @user = User.new(params[:user])
      if @user.save
        sign_in @user
        flash[:success] = "Welcome to the Sample App"
        redirect_to @user
      else
        render 'new'
      end
    end
  end
  
  def edit
  end
  
  def update
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated successfully"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  def index
    @users = User.paginate(page: params[:page])
  end
  
  def destroy
    @user = User.find(params[:id])
    if current_user?(@user)
      flash[:notice] = "Can not delete your own account"
      redirect_to users_url
    else
      User.find(params[:id]).destroy
      flash[:success] = "User destroyed."
      redirect_to users_url
    end
  end
  
private
  
  def correct_user
    @user = User.find(params[:id])
    if !current_user?(@user)
      flash[:notice] = "Can't update another user"
      redirect_to(@user || root_path)
    end 
  end
  
  def admin_user
    if !current_user.admin?
      flash[:notice] = "Only an admin can delete another user"
      redirect_to(users_url)
    end
  end
  
end
