class TasksController < ApplicationController
  def index
    @tasks = Task.where(is_done: false).order(:deadline)
    @task = Task.new
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
      flash[:notice] = 'タスクを作成しました'
      # redirect_to :root
      head 201
    else
      render json: {messages: @task.errors.full_messages}, status: 422
    end
  end

  def edit
    @task = Task.find(params[:id])
    if @task
      render json: @task
    else
      render json: {messages: @task.errors.full_messages}, status: 422
    end
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      flash[:notice] = 'タスクを更新しました'
      head 201
    else
      render json: {messages: @task.errors.full_messages}, status: 422
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
