require 'rails_helper'

# describe AchievementsController, type: :controller do
describe AchievementsController do

  describe 'GET index' do
    it 'renders :index template' do
      get :index
      expect(response).to render_template(:index)
    end
    it 'assigns only public achievements to template' do
      public_achievement = FactoryGirl.create(:public_achievement)
      private_achievement = FactoryGirl.create(:private_achievement)
      get :index
      expect(assigns(:achievements)).to match_array([public_achievement])
    end
  end

  describe 'GET edit' do
    let(:achievement) { FactoryGirl.create(:public_achievement) }

    it 'renders :edit template' do
      get :edit, params: {id: achievement}
    end
    it 'assigns the requested achievement to template' do
      get :edit, params: {id: achievement}
      expect(assigns(:achievement)).to eq(achievement)
    end
  end

  describe 'GET new' do
    it 'renders :new template' do
      get :new
      expect(response).to render_template(:new)
    end
    it 'assigns new Achievement to @achievement' do
      get :new
      expect(assigns(:achievement)).to be_a_new(Achievement)
    end
  end

  describe 'GET show' do
    let(:achievement) { FactoryGirl.create(:public_achievement) }

    it 'renders :show template' do
      get :show, params: { id: achievement.id }
      expect(response).to render_template(:show)
    end
    it 'assigns requested achievement to @achievement' do
      get :show, params: { id: achievement.id }
      expect(assigns(:achievement)).to eq(achievement)
    end
  end

  describe 'PUT update' do
    let(:achievement) { FactoryGirl.create(:public_achievement) }

    context 'valid data' do
      let(:valid_data) { FactoryGirl.attributes_for(:public_achievement, title: 'New Title') }

      it 'redirects to achievements#show' do
        put :update, params: {id: achievement, achievement: valid_data}
        expect(response).to redirect_to(achievement)
      end
      it 'updates achievement in the database' do
        put :update, params: {id: achievement, achievement: valid_data}
        achievement.reload
        expect(achievement.title).to eq('New Title')
      end
    end

    context 'invalid data' do
      let(:invalid_data) { FactoryGirl.attributes_for(:public_achievement, title: '', description: 'new') }

      it 'renders :edit template' do
        put :update, params: {id: achievement, achievement: invalid_data}
        expect(response).to render_template(:edit)
      end
      it "doesn't update achievement in the database" do
        put :update, params: {id: achievement, achievement: invalid_data}
        achievement.reload
        expect(achievement.description).not_to eq('new')
      end
    end
  end

  describe 'POST create' do

    context 'valid data' do
      let(:valid_data) { FactoryGirl.attributes_for(:public_achievement) }
      it 'redirects to achievements#show' do
        post :create, params: { achievement: valid_data }
        expect(response).to redirect_to(achievement_path(assigns[:achievement]))
      end
      it 'creates new achievement in database' do
        expect {
          post :create, params: { achievement: valid_data }
        }.to change(Achievement, :count).by(1)
      end
    end

    context 'invalid data' do
      let(:invalid_data) { FactoryGirl.attributes_for(:public_achievement, title: '') }

      it 'renders :new template' do
        post :create, params: { achievement: invalid_data }
        expect(response).to render_template(:new)
      end
      it 'does not create new achievement in the database' do
        expect {
          post :create, params: { achievement: invalid_data }
        }.not_to change(Achievement, :count)
      end
    end
  end

  describe 'DELETE destroy' do
    let(:achievement) {FactoryGirl.create(:public_achievement)}
    it 'redirects to achievements#index' do
      delete :destroy, params: {id: achievement}
      expect(response).to redirect_to(achievements_path)
    end
    it 'deletes achievement from database' do
      delete :destroy, params: {id: achievement}
      expect(Achievement.exists?(achievement.id)).to be_falsy
    end
  end
end
