class ListsController < ApplicationController
  before_action :set_list, only: [:update, :destroy]
  before_action :authenticate_user!

  def index
    @lists = current_user.lists
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
      @list = List.find(params[:id])
    end


    def list_params
      params.require(:list).permit(:name)
    end
end
