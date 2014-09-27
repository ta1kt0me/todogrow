class TasksController < ApplicationController
  def index
    @tasks = Task.where(is_done: false).order(:deadline)
  end

  def closed_index
    @tasks = Task.where(is_done: true).order('updated_at DESC')
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

  def close
    @task = Task.find(params[:id])
    if @task.update(is_done: true)
      redirect_to :root
    else
      render :root
    end
  end

  private
  def task_params
    params.require(:task).permit(
      :name, :deadline
    )
  end
end
