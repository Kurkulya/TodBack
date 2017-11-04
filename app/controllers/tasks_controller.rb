class TasksController < ApplicationController
  before_action :set_list_task
  def index
  end

  def show
  end

  def new
    @task = Task.new
  end

  def edit
  end

  def create
    @task = @list.tasks.new(task_params)
    @task.position = @list.tasks.count + 1
    if @task.save
      redirect_to lists_path
    else
      render :new
    end
  end

  def update
    if @task.update(task_params)
      redirect_to lists_path
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to lists_path
  end



  def up_position
    if @task.position != 1
      @task.swap_positions(@task.position - 1)
      redirect_to lists_path
    end
  end

  def down_position
    if @task.position != @list.tasks.count
      @task.swap_positions( @task.position + 1)
      redirect_to lists_path
    end
  end



  def check
    @task.update(is_done: !@task.is_done)
    redirect_to lists_path
  end


  private

  def set_list_task
    @list = List.find(params[:list_id])
    if(params.has_key?(:id))
      @task = Task.find(params[:id])
    elsif(params.has_key?(:task_id))
      @task = Task.find(params[:task_id])
    end
  end

  def task_params
    params.require(:task).permit(:content, :position, :is_done, :list_id)
  end
end
