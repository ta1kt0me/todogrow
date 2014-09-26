class TasksController < ApplicationController
  def index
    @tasks = Task.order(:deadline)
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to :root
    else
      render :new
    end
  end

  private
  def task_params
    params.require(:task).permit(
      :name, :deadline
    )
  end
end
