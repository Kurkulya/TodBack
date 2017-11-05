class TasksController < ApplicationController
  before_action :set_task, only:[:update, :destroy, :up_position, :down_position, :check]

  def create
    list = List.find(task_params[:list_id])
    @task = list.tasks.new(task_params)

    @task.position = list.tasks.count + 1

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



  def up_position
    if @task.position != 1
      @task.swap_positions(@task.position - 1)
      render json: @task, status: :ok
    end
  end

  def down_position
    if @task.position != @list.tasks.count
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

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:content, :position, :is_done, :list_id)
  end
end
