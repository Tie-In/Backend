require 'rails_helper'

describe Api::V1::OrganizationsController, type: :controller do
  context 'POST #create' do
    before(:each) do
      @user = FactoryGirl.create(:user)
      @organization = {
        name: 'Tiein',
        description: 'Test create'
      }
    end

    subject do
      @org_json = @organization.as_json
      post :create, organization: @org_json
    end

    it 'success organization with no collaborator' do
      subject
      allow(controller).to receive(:current_user).and_return(@user)
      expect(response).to have_http_status(:created)
    end
  end
end
