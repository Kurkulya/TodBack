require 'rails_helper'

describe V1::TasksController, :type => :controller do

  before do
    authenticate_user
    @list = FactoryGirl.create(:list, user_id: @user.id)
  end

  describe "GET 'tasks'/'index'" do
    it ' should return HTTP status 200' do
      get :index, params: { list_id: @list.id }, format: :json
      expect(response).to have_http_status (:success)
    end

    describe 'should return all tasks in list for current user: ' do
      it '0 tasks' do
        get :index, params: { list_id: @list.id }, format: :json
        tasks = JSON.parse(response.body)
        expect(tasks.size).to eq(0)
      end
      it '1 tasks' do
        FactoryGirl.create(:task, list_id: @list.id)
        get :index, params: { list_id: @list.id }, format: :json
        tasks = JSON.parse(response.body)
        expect(tasks.size).to eq(1)
      end
      it '5 tasks' do
        FactoryGirl.create_list(:task, 5, list_id: @list.id)
        get :index, params: { list_id: @list.id }, format: :json
        tasks = JSON.parse(response.body)
        expect(tasks.size).to eq(5)
      end
    end
  end

  describe "POST 'task'/'create'" do
    it ' should return HTTP status 200' do
      post :create, params: { task: { label: 'test label' }, list_id: @list.id }, format: :json
      expect(response).to have_http_status (:success)
    end

    it ' should not create task with empty label' do
      post :create, params: { task: { label: '' }, list_id: @list.id }, format: :json
      expect(response).to have_http_status (:unprocessable_entity)
    end

    describe 'should create tasks: ' do
      it '1 task' do
        post :create, params: { task: { label: 'test label' }, list_id: @list.id }, format: :json
        get :index, params: { list_id: @list.id }, format: :json
        tasks = JSON.parse(response.body)
        expect(tasks.size).to eq(1)
      end

      it '5 tasks' do
        (0..4).each do |i|
          post :create, params: { task: { label: "label #{i}"}, list_id: @list.id }, format: :json
        end
        get :index, params: { list_id: @list.id }, format: :json
        expect(JSON.parse(response.body).size).to eq(5)
      end
    end
  end

  describe "PATCH 'task'/'update'" do
    it ' should return HTTP status 200' do
      task = FactoryGirl.create(:task, list_id: @list.id)
      patch :update, params: { id: task.id, list_id: @list.id, task: { label: 'updated label' } }, format: :json
      expect(response).to have_http_status (:success)
    end

    it ' should update task label' do
      task = FactoryGirl.create(:task, list_id: @list.id)
      patch :update, params: { id: task.id, list_id: @list.id, task: { label: 'updated label' } }, format: :json
      expect(JSON.parse(response.body)['label']).to eq('updated label')
    end

    it ' should not update task label to empty' do
      task = FactoryGirl.create(:task, list_id: @list.id)
      patch :update, params: { id: task.id, list_id: @list.id, task: { label: '' } }, format: :json
      expect(response).to have_http_status (:unprocessable_entity)
    end
  end

  describe "DELETE 'task'/'destroy'" do
    it ' should destroy task' do
      task = FactoryGirl.create(:task, list_id: @list.id)
      delete :destroy, params: { id: task.id, list_id: @list.id }, format: :json
      expect(response).to have_http_status (:success)
    end

    it ' should not destroy not existed task' do
      delete :destroy, params: { id: -1, list_id: @list.id }, format: :json
      expect(response).to have_http_status (:unprocessable_entity)
    end
  end

end