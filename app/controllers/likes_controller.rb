class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_idea

  def create
    l = Like.new
    l = Like.new(idea: @idea, user: current_user)

    if l.save
      # redirect_to @idea, notice: "Liked idea!"
      redirect_to request.referer, notice: "Liked idea!"
    else
      # redirect_to @idea, alert: "Like failed!"
      redirect_to request.referer, alert: "Like failed!"
    end
  end

  def destroy
    l = Like.find params[:id]

    if can? :destroy, l
      l.destroy
      # redirect_to @idea, notice: "Disliked idea!"
      redirect_to request.referer, notice: "Disliked idea!"
    else
      redirect_to root_path, alert: "Access denied!"
    end
  end

  private

  def find_idea
    @idea = Idea.find params[:idea_id]
  end
end
