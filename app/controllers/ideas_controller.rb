class IdeasController < ApplicationController
  before_action :require_login 

  def index
    @user = User.find(session[:user_id])
    @ideas = Idea.joins("JOIN users ON ideas.user_id = users.id").select("ideas.id", "ideas.content", "ideas.likecount", "ideas.user_id", "users.alias", "ideas.likers").order("ideas.likers DESC")
  end

  def create
    creator = User.find(session[:user_id])
    idea = Idea.new(:content => params[:content], :user => creator, :likecount => 0, :likers => 0)

    if idea.valid?
      idea.save
      redirect_to :back
    else
      flash[:ideaerror] = ["Ideas must be at least 15 characters long"]
      redirect_to :back
    end
  end
  def show
    @idea = Idea.joins("JOIN users ON users.id = ideas.user_id").select("ideas.content", "users.alias", "users.id").where(:id => params[:id])
    @likers = Like.joins("JOIN users ON users.id = likes.user_id").select("users.alias", "users.name", "users.id").where(:idea_id => params[:id])
  end

  def destroy
    idea = Idea.find(params[:id])
    destroyed = idea.destroy
    redirect_to '/ideas'
  end
end
