class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :following, :followers]

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    @entry = current_user.entries.build if logged_in?
    @user = User.find(params[:id])
    @entries = @user.entries.paginate(page: params[:page])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # success
      log_in @user
      redirect_to @user
    else
      render 'new'
    end
  end

  def login
    if logged_in?
      @user = User.find_by(id: session[:user_id])
      redirect_to @user
    end
  end

  def create_sessions
    user = User.find_by(email: params[:login][:email].downcase)
    if user && user.authenticate(params[:login][:password])
      log_in user
      redirect_to user
    else
      flash[:danger] = 'Email hoặc mật khẩu không đúng!'
      render 'login'
    end
  end

  def logout
    log_out
    redirect_to root_url
  end

  def following
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
