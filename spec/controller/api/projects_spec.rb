require 'rails_helper'

describe Api::V1::ProjectsController, type: :controller do
  context 'POST #create' do
    before(:each) do
      @user = FactoryGirl.create(:user)
      @organization = FactoryGirl.create(:organization)
      @project = {
        name: 'Test',
        description: 'Test create project',
        organization_id: @organization.id
      }
    end

    subject do
      @project_json = @project.as_json
      post :create, project: @project_json
    end

    it 'success project with no collaborator' do
      allow(controller).to receive(:current_user).and_return(@user)
      subject
      expect(response).to have_http_status(:created)
    end

    it 'success project with collaborators' do
      @col = FactoryGirl.create(:user)
      @project['users'] = [ @col ]
      allow(controller).to receive(:current_user).and_return(@user)
      subject
      expect(response).to have_http_status(:created)
    end
  end
end
