require 'rails_helper'

describe Api::V1::UsersController, type: :controller do

  context 'GET #index' do
    before(:all) do
      FactoryGirl.create_list(:user, 5)
    end

    it 'all users' do
      get :index
      users = JSON.parse(response.body)

      # test for the 200 status-code
      expect(response).to be_success

      expect(users.length).to eq(5)
    end
  end

  context 'POST #create' do
    before(:each) do
      @user = {
        email: 'tiein@tiein.com',
        username: 'tiein',
        password: 12341234,
        password_confirmation: 12341234,
        firstname: 'John',
        lastname: 'Doe',
        phone_number: '088888888'}
      @user_json = @user.as_json
    end

    subject do
      post :create, user: @user_json
    end

    it 'success user' do
      subject
      expect(response).to be_success
    end

    it 'have same username' do
      subject
      @user['email'] = 'tiein1@tiein.com'
      dup_json = @user.as_json

      post :create, user: dup_json
      expect(response).to have_http_status(422)
    end

    it 'have same email' do
      subject
      @user['username'] = 'tiein'
      dup_json = @user.as_json

      post :create, user: dup_json
      expect(response).to have_http_status(422)
    end
  end
end
