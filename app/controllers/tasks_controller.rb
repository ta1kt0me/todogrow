class TasksController < ApplicationController
  def index
    if current_user
      @tasks = Task.where(is_done: false, user: current_user).order(:deadline)
      @task = Task.new
      @user_tags = current_user.owned_tag_list
    end
  end

  # TODO feature tag
  def closed_index
    @tasks = Task.where(is_done: true, user: current_user).order('updated_at DESC')
    @task = Task.new
    @user_tags = current_user.owned_tag_list
  end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.build(task_params)
    @task.user = current_user
    if @task.save &&
        current_user.tag(@task, with: @task.tag_list.join(', '), on: :tags)
      flash[:notice] = 'タスクを作成しました'
      head 201
    else
      render json: {messages: @task.errors.full_messages}, status: 422
    end
  end

  # TODO feature tag
  def edit
    @task = Task.find(params[:id])
    if @task
      render json: {task: @task, tag:@task.tag_list}
    else
      render json: {messages: @task.errors.full_messages}, status: 422
    end
  end

  # TODO feature tag
  def update
    @task = Task.find(params[:id])
    if @task.update(task_params) &&
        current_user.tag(@task, with: @task.tag_list.join(', '), on: :tags)
      flash[:notice] = 'タスクを更新しました'
      head 201
    else
      render json: {messages: @task.errors.full_messages}, status: 422
    end
  end

  def close
    @task = Task.find(params[:id])
    if @task.update(is_done: true)
      render json: @task
    else
      render json: {messages: @task.errors.full_messages}, status: 422
    end
  end

  private
  def task_params
    params.require(:task).permit(
      :id, :name, :deadline, tag_list: []
    )
  end
end
