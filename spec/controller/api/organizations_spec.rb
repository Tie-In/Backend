require 'rails_helper'

describe Api::V1::OrganizationsController, type: :controller do
  context 'POST #create' do
    before(:each) do
      @user = FactoryGirl.create(:user)
    end

    # subject do
    #   @login_json = @login.as_json
    #   post :create, session: @login_json
    # end

    # it 'organization' do
    #   subject
    #   allow(controller).to receive(:current_user).and_return(@user)
    #   expect(response).to have_http_status(:created)
    # end
  end
end
