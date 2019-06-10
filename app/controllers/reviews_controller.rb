class ReviewsController < ApplicationController
  before_action :set_task
  before_action :authenticate_user!
  def new
    @review = Review.new(task: @task)
  end
   
  def create 
    @review = current_user.reviews.build(review_params)
    @review.task = @task 
    @review.save 
    redirect_to @task
  end
  def edit
  end
  
  private 
  
  def set_task 
    @task = Task.find(params[:task_id])
  end 
  
  def review_params 
    params.require(:review).permit(:comment, :rating)
  end
end
