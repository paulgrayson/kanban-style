require 'rails_helper'

describe ProjectsController do
  describe 'GET index' do
    it 'renders the template' do
      subject.stub(:fetch_projects).and_return({})
      get :index
      expect(response).to render_template('index')
    end
  end

  describe 'GET show' do
    let(:id) { '1' }

    before do
      subject.stub(:fetch_project).with(id).and_return(project)
    end

    context 'valid project id' do
      let(:project) { {} }

      it 'renders the template' do
        get :show, id: id
        expect(response).to render_template('projects/show')
      end
    end

    context 'invalid project id' do
      let(:project) { nil }

      it 'redirects to index' do
        get :show, id: id
        expect(response).to redirect_to(projects_path)
      end
    end
  end
end

