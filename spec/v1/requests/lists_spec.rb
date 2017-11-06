describe V1::ListsController, :type => :controller do

  before do
    authenticate_user
  end

  it 'returns HTTP status 200' do
    get 'lists'
    expect(response).to have_http_status 200
  end

  # it 'returns all users' do
  #   body = JSON.parse(response.body)
  #   expect(body['data'].size).to eq(10)
  # end
end