class V1::TasksController < ApplicationController
  before_action :find_task, only: [:update, :destroy]
  before_action :find_list, only: [:index, :create]

  def index
    @tasks = @list.tasks
    render json: @tasks, status: :ok
  end

  def create
    @task = @list.tasks.new(task_params)
    @task.position = @list.tasks.count + 1
    if @task.save
      render json: @task, status: :created
    else
      render json: @task, status: :unprocessable_entity
    end
  end

  def update
    if @task.update(task_params)
      render json: @task, status: :ok
    else
      render json: @task, status: :unprocessable_entity
    end
  end

  def destroy
    if @task && @task.destroy
      head(:ok)
    else
      head(:unprocessable_entity)
    end
  end

  def up_position
    if @task.position != 1
      @task.swap_positions(@task.position - 1)
      render json: @task, status: :ok
    end
  end

  def down_position
    list = List.find(params[:list_id])
    if @task.position != list.tasks.count
      @task.swap_positions( @task.position + 1)
      render json: @task, status: :ok
    end
  end

  def check
    if @task.update(is_done: !@task.is_done)
      render json: @task, status: :ok
    else
      render json: @task, status: :unprocessable_entity
    end
  end

  private

  def task_params
    params.require(:task).permit(:content, :list_id)
  end

  def find_task
    if params.key?('id')
      @task = Task.find_by(id: params[:id])
    elsif params.key?('task_id')
      @task = Task.find_by(task_id: params[:task_id])
    end
  end

  def find_list
    @list = List.find_by(id: params[:list_id])
  end
end
