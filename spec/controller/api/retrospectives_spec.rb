require 'rails_helper'

describe Api::V1::RetrospectivesController, type: :controller do
  context 'POST #create' do
    before(:each) do
    	@user = FactoryGirl.create(:user)
      @sprint = FactoryGirl.create(:sprint)
      @retrospective = {
        sprint_id: @sprint.id,
      }
    end

    subject do
      @retro_json = @retrospective.as_json
      post :create, retrospective: @retro_json
    end

    it 'start retrospective' do
      allow(controller).to receive(:current_user).and_return(@user)
      subject
      expect(response).to have_http_status(:created)

      retro = JSON.parse(response.body)
      expect(retro['number']).to eq(@sprint.number)

      expect(retro['status']).to eq("in_progress")
    end
  end

  context 'PUT #update' do
    before(:each) do
    	@user = FactoryGirl.create(:user)
      @sprint = FactoryGirl.create(:sprint)
      @retrospective = FactoryGirl.create(
        :retrospective, :in_progress, number: @sprint.number, sprint: @sprint
      )
    end

    it 'update status' do
      update = {
        status: 'categorise'
      }
      update_json = update.as_json
      allow(controller).to receive(:current_user).and_return(@user)
      put :update, { id: @retrospective.id, retrospective: update_json }

      retro = JSON.parse(response.body)
      expect(response).to be_success
      expect(retro['status']).to eq('categorise')
    end

    it 'cannot update other attributes' do
      update = {
        number: 0
      }
      update_json = update.as_json
      allow(controller).to receive(:current_user).and_return(@user)
      put :update, { id: @retrospective.id, retrospective: update_json }

      retro = JSON.parse(response.body)
      expect(response).to be_success
      expect(retro['number']).to eq(@sprint.number)
    end
  end
end
