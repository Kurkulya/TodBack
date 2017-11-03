class V1::TasksController < ApplicationController
before_action :find_task, only: [:update, :destroy]

  def create
    @list = List.find(params[:list_id])
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
    if @task.destroy
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
    @task = Task.find(params[:id])
  end
end
