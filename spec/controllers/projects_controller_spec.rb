require 'rails_helper'

describe ProjectsController do

  let(:api_token) { double }

  # ensure no method on any PivotalClient instance is called
  before do
    session[:api_token] = api_token
    @pivotal_stub = double(set_token: nil)
    subject.stub(:pivotal).and_return(@pivotal_stub)
  end

  describe 'GET index' do
    before { @pivotal_stub.stub(fetch_projects: []) }

    it 'renders the template' do
      get :index
      expect(response).to render_template('index')
    end

    it 'set the api token' do
      @pivotal_stub.should_receive(:set_token).with(api_token)
      get :index
    end

    it 'redirects to root when no api_token' do
      session[:api_token] = nil
      get :index
      expect(response).to redirect_to(root_path)
    end
  end

  describe 'GET show' do
    context 'valid project id' do
      before { @pivotal_stub.stub(fetch_project: double) }

      it 'renders the template' do
        get :show, id: '123'
        expect(response).to render_template('projects/show')
      end

      it 'redirects to root when no api_token' do
        session[:api_token] = nil
        get :show, id: '123'
        expect(response).to redirect_to(root_path)
      end
    end

    context 'invalid project id' do
      it 'redirects to index' do
        @pivotal_stub.stub(fetch_project: nil)
        get :show, id: '234'
        expect(response).to redirect_to(projects_path)
      end
    end
  end

end

