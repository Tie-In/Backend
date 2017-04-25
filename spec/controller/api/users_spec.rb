require 'rails_helper'

describe Api::V1::UsersController, type: :controller do

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
      expect(response).to have_http_status(:created)
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

    it 'have nil value' do
      user = {
        email: 'tiein@tiein.com',
        password: 12341234,
        password_confirmation: 12341234,
        firstname: 'John',
        lastname: 'Doe',
        phone_number: '088888888'}
      user_json = user.as_json
      post :create, user: user_json
      expect(response).to have_http_status(422)
    end
  end

  context 'PUT #update' do
    before(:all) do
      @user = FactoryGirl.create(:login_user)
    end

    it 'success' do
      update = {
        firstname: 'Jane'
      }
      update_json = update.as_json
      allow(controller).to receive(:current_user).and_return(@user)
      put :update, { id: @user.id, user: update_json }

      user = JSON.parse(response.body)
      expect(response).to be_success
      expect(user['firstname']).to eq('Jane')
    end
  end
end
