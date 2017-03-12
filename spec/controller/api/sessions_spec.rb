require 'rails_helper'

describe Api::V1::SessionsController, type: :controller do
  context 'POST #create' do
    before(:each) do
      @user = FactoryGirl.create(:user)
      @login = {
        email: @user.email,
        password: @user.password,
      }
    end

    subject do
      @login_json = @login.as_json
      post :create, session: @login_json
    end

    it 'login with email' do
      subject
      expect(response).to have_http_status(:created)
    end

    it 'login with username' do
      @login['email'] = @user.username
      subject
      expect(response).to have_http_status(:created)
    end

    it 'not authorized user' do
      # no email
      @login['email'] = 'test@test.com'
      subject
      expect(response).to have_http_status(401)

      @login = {
        email: @user.email,
        password: 1,
      }
      subject
      expect(response).to have_http_status(401)
    end
  end
end
