class V1::ListsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_list, only: [:update, :destroy]

  def index
    @lists = current_user.lists

    render :index, status: :ok
  end

  def create
    @list = current_user.lists.new(list_params)

    if @list.save
      render json: @list, status: :created
    else
      render json: @list, status: :unprocessable_entity
    end
  end

  def update
    if @list.update(list_params)
      render json: @list, status: :ok
    else
      render json: @list, status: :unprocessable_entity
    end
  end

  def destroy
    if @list.destroy
      head(:ok)
    else
      head(:unprocessable_entity)
    end
  end

  private

  def set_list
    @list = current_user.lists.find(params[:id])
  end

  def list_params
    params.require(:list).permit(:label)
  end
end
