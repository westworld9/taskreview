class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :update, :destroy]
  
  def new 
    @task = Task.new
  end 
  
  def index 
    @q = Task.ransack(params[:q])
    @tasks = @q.result(distinct: true).page(params[:page]).per(10)
  end
  
  def create
    @task = current_user.tasks.build(task_params)
    
    if @task.save
      redirect_to tasks_url, notice: "タスク「#{@task.name}」を登録しました。"
    else 
      render :new 
    end
  end

  def show
    @reviews = Review.where(task_id: @task) 
    if @reviews.blank?
      @avg_rating = 0 
    else 
      @ave_rating = @reviews.average(:rating).round(2)
    end
  end

  def edit
  end
  
  def update 
    @task.update!(task_params)
    redirect_to tasks_url, notice: "タスク「#{@task.name}」を更新しました。"
  end
  
  def destroy 
    @task.destroy 
    redirect_to tasks_url, notice: "タスク「#{@task.name}を削除しました。"
  end
  
  private 
  
  def set_task 
    @task = Task.find(params[:id])
  end
  
  def task_params
    params.require(:task).permit(:name, :description, :image)
  end
end
