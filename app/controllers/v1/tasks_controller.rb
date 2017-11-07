class V1::TasksController < ApplicationController
  before_action :find_task, only: [:update, :destroy]
  before_action :find_list, only: [:index, :create]

  def index
    @tasks = @list.tasks
    render json: @tasks, status: :ok
  end

  def create
    @task = @list.tasks.new(task_params)

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

  private

  def task_params
    params.require(:task).permit(:label, :list_id)
  end

  def find_task
    @task = Task.find_by(id: params[:id])
  end

  def find_list
    @list = List.find_by(id: params[:list_id])
  end
end
