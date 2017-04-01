require 'rails_helper'

describe Api::V1::OrganizationsController, type: :controller do
  context 'GET #show' do
     before(:each) do
      @user = FactoryGirl.create(:user)
      @organization = {
        name: 'Tiein',
        description: 'Test create'
      }
    end
    
    it 'must be collaborators in the organization' do
      get :index

      users = JSON.parse(response.body)
      # test for the 200 status-code
      expect(response).to be_success

      expect(users.length).to eq(5)
    end
  end

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
      allow(controller).to receive(:current_user).and_return(@user)
      subject
      expect(response).to have_http_status(:created)
    end

    it 'success organization with collaborators' do
      @col = FactoryGirl.create(:user)
      @organization['users'] = [ @col ]
      allow(controller).to receive(:current_user).and_return(@user)
      subject
      expect(response).to have_http_status(:created)
    end
  end
end
