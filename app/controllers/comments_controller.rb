class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @idea = Idea.find params[:idea_id]
    @comment = Comment.new comment_params
    @comment.idea = @idea
    @comment.user = current_user

    if @comment.save
      redirect_to idea_path(@idea), notice: "Comment committed to memory!"
    else
      flash[:alert] = "Oops.."
      render "/ideas/show"
    end
  end

  def destroy
    @idea = Idea.find params[:idea_id]
    @comment = Comment.find params[:id]
    @comment.destroy
    redirect_to idea_path(@idea), notice: "Comment removed."
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

end
