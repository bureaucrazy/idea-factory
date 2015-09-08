class JoinsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_idea

  def create
    j = Join.new
    j = Join.new(idea: @idea, user: current_user)

    if j.save
      # redirect_to @idea, notice: "Joined idea!"
      redirect_to request.referer, notice: "Joined idea!"
    else
      # redirect_to @idea, alert: "Join failed!"
      redirect_to request.referer, alert: "Join failed!"
    end
  end

  def destroy
    j = Join.find params[:id]

    if can? :destroy, j
      j.destroy
      # redirect_to @idea, notice: "Left idea!"
      redirect_to request.referer, notice: "Left idea!"
    else
      redirect_to root_path, alert: "Access denied!"
    end
  end

  private

  def find_idea
    @idea = Idea.find params[:idea_id]
  end
end
