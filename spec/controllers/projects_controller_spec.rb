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
    context 'valid project id' do
      it 'renders the template' do
        ProjectPresenter.any_instance.stub(found_project?: true)
        get :show, id: '123'
        expect(response).to render_template('projects/show')
      end
    end

    context 'invalid project id' do
      it 'redirects to index' do
        ProjectPresenter.any_instance.stub(found_project?: false)
        get :show, id: '234'
        expect(response).to redirect_to(projects_path)
      end
    end
  end
end

