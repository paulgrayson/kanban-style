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
    context 'valid project id' do
      it 'renders the template' do
        id = '1'
        subject.stub(:fetch_project).with(id).and_return({})
        get :show, id: id
        expect(response).to render_template('projects/show')
      end
    end

    context 'invalid project id' do
      it 'redirects to index' do
        id = 'banana'
        subject.stub(:fetch_project).with(id).and_return(nil)
        get :show, id: id
        expect(response).to redirect_to(projects_path)
      end
    end
  end
end

