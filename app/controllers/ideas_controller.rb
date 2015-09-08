class IdeasController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  before_action :find_idea, only: [:show, :edit, :update, :destroy]
  before_action :authorize!, only: [:edit, :update, :destroy]

  def new
    @idea = Idea.new(title: "Eureka!")
  end

  def create
    @idea = Idea.new(idea_params)
    @idea.user = current_user
    if @idea.save
      redirect_to idea_path(@idea), notice: "Idea committed to memory!"
    else
      flash[:alert] = "Oops.."
      render :new
    end
  end

  def show
    @comment = Comment.new
  end

  def index
    if params[:search]
      @ideas = Idea.search(params[:search]).order(:id)
    else
      @ideas = Idea.all.order(:id)
    end
  end

  def edit
  end

  def update
    if @idea.update idea_params
      redirect_to idea_path(@idea)
    else
      render :edit
    end
  end

  def destroy
    @idea.destroy
    redirect_to ideas_path
  end

  private

  def find_idea
    @idea = Idea.find params[:id]
  end

  def authorize!
    redirect_to root_path, alert: "Access denied!" unless can? :manage, @idea
  end

  def idea_params
    params.require(:idea).permit([:title, :body])
  end
end
