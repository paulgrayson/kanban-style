require 'rails_helper'

describe ProjectsController do

  # ensure no method on any PivotalClient instance is called
  before do
    @pivotal_stub = double
    subject.stub(:pivotal).and_return(@pivotal_stub)
  end

  describe 'GET index' do
    it 'renders the template' do
      @pivotal_stub.stub(fetch_projects: [])
      get :index
      expect(response).to render_template('index')
    end
  end

  describe 'GET show' do
    let(:id) { '1' }

    before do
      @pivotal_stub.stub(fetch_project: project)
      @pivotal_stub.stub(fetch_stories: [])
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

