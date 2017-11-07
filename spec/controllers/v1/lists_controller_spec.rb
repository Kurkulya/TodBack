require 'rails_helper'

describe V1::ListsController, :type => :controller do

  before do
    authenticate_user
  end

  describe "GET 'list'/'index'" do
    it ' should return HTTP status 200' do
      get :index, format: :json
      expect(response).to have_http_status (:success)
    end

    describe 'should return all lists for current user: ' do
      it '0 lists' do
        get :index, format: :json
        lists = JSON.parse(response.body)
        expect(lists.size).to eq(0)
      end
      it '1 list' do
        FactoryGirl.create(:list, user_id: @user.id)
        get :index, format: :json
        lists = JSON.parse(response.body)
        expect(lists.size).to eq(1)
      end
      it '5 lists' do
        FactoryGirl.create_list(:list, 5, user_id: @user.id)
        get :index, format: :json
        lists = JSON.parse(response.body)
        expect(lists.size).to eq(5)
      end
    end
  end

  describe "POST 'list'/'create'" do
    it ' should return HTTP status 200' do
      post :create, params: { list: { label: 'test label', user_id: @user.id } }, format: :json
      expect(response).to have_http_status (:success)
    end

    it ' should not create list with empty label' do
      post :create, params: { list: { label: '', user_id: @user.id } }, format: :json
      expect(response).to have_http_status (:unprocessable_entity)
    end

    describe 'should create lists: ' do
      it '1 list' do
        post :create, params: { list: { label: 'test label', user_id: @user.id } }, format: :json
        get :index, format: :json
        lists = JSON.parse(response.body)
        expect(lists.size).to eq(1)
      end

      it '5 lists' do
        (0..4).each do |i|
          post :create, params: { list: { label: "label #{i}", user_id: @user.id } }, format: :json
        end
        get :index, format: :json
        expect(JSON.parse(response.body).size).to eq(5)
      end
    end
  end

  describe "PATCH 'list'/'update'" do
    it ' should return HTTP status 200' do
      list = FactoryGirl.create(:list, user_id: @user.id)
      patch :update, params: { id: list.id, list: { label: 'updated label' } }, format: :json
      expect(response).to have_http_status (:success)
    end

    it ' should update list label' do
      list = FactoryGirl.create(:list, user_id: @user.id)
      patch :update, params: { id: list.id, list: { label: 'updated label' } }, format: :json
      expect(JSON.parse(response.body)['label']).to eq('updated label')
    end

    it ' should not update list label to empty' do
      list = FactoryGirl.create(:list, user_id: @user.id)
      patch :update, params: { id: list.id, list: { label: '' } }, format: :json
      expect(response).to have_http_status (:unprocessable_entity)
    end
  end

  describe "DELETE 'list'/'destroy'" do
    it ' should destroy list' do
      list = FactoryGirl.create(:list, user_id: @user.id)
      delete :destroy, params: { id: list.id }, format: :json
      expect(response).to have_http_status (:success)
    end

    it ' should not destroy not existed list' do
      delete :destroy, params: { id: -1 }, format: :json
      expect(response).to have_http_status (:unprocessable_entity)
    end
  end

end