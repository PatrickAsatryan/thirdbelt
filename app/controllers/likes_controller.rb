class LikesController < ApplicationController
  before_action :require_login
  
  def create
    user = User.find(session[:user_id])
    idea = Idea.find(params[:id])
    if Like.where("user_id = #{session[:user_id]} and idea_id = #{params[:id]}").any?
      plusone = idea.increment!(:likecount, 1)
    else
      plusanyways = idea.increment!(:likecount, 1)
      likerplus = idea.increment!(:likers, 1)
      likenew = Like.create(:user => user, :idea => idea)
    end
    redirect_to '/ideas'
  end
end
