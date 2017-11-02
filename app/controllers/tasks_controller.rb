class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy, :up_position, :down_position, :check]
  before_action :set_list, only: [:index, :new, :up_position, :down_position, :check]
  # GET /tasks
  # GET /tasks.json
  def index
    @tasks = @list.tasks.order(:position)
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = @list.tasks.new(task_params)
    @task.position = Task.all.count + 1
    #@task.is_done = false
    if @task.save
      redirect_to controller: :tasks
    else
      render :new
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    if @task.update(task_params)
      redirect_to controller: :tasks
    else
      render :edit
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy
      redirect_to list_tasks_path
  end

  def up_position
    if @task.position != 1
      upper_task = Task.where(position: @task.position - 1).first
      upper_task.position, @task.position = @task.position, upper_task.position
      upper_task.save
      @task.save
      redirect_to @list
    end
  end

  def down_position
    if @task.position != Task.all.count
      downer_task = Task.where(position: @task.position + 1).first
      downer_task.position, @task.position = @task.position, downer_task.position
      downer_task.save
      @task.save
      redirect_to @list
    end
  end

  def check
    @task.is_done = !@task.is_done
    @task.save
    redirect_to @list
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      if(params.has_key?(:id))
        @task = Task.find(params[:id])
      elsif(params.has_key?(:task_id))
        @task = Task.find(params[:task_id])
      end
    end

    def set_list
      @list = Task.find(params[:list_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:content, :position, :is_done)
    end
end
