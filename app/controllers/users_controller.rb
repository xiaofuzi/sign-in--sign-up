class UsersController < ApplicationController
  before_action :signed_in_user, only: [:index, :edit, :show, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy

  def index
    @users = User.paginate(page: params[:page])
  end
  def edit
  end

  

  def new
  	@user = User.new
  end

  def show
  	@user       = User.find(params[:id])
    @art        = @user.articles.paginate(page: params[:page])
    @articles   = @user.articles.paginate(page: params[:page])
    @schoolnews = @user.schoolnews.paginate(page: params[:page])
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
      
      sign_in @user
  		flash[:success] = "欢迎来到传播者!"
  		redirect_to @user
  	else
  		render 'new'
  	end
  end


  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_url
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

    # Before filters

    

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
end

