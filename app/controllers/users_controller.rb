class UsersController < ApplicationController
  before_action :require_login, only: [:show] 
  
  def show
    @user = User.find(params[:id])
    @likes = Idea.where(:user_id => @user).sum(:likecount)
    @posts = Idea.where(:user_id => @user).count
  end

  def create
    user = User.new(user_params)

    if user.valid?
      user.save
      session[:user_id] = user.id
      redirect_to "/ideas"
    else
      flash[:reg] = user.errors.full_messages
      redirect_to :back
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :alias, :email, :password, :password_confirmation)
  end
end
