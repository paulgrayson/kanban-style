require 'rails_helper'

describe StreamController do

  let(:api_token) { double }

  # ensure no method on any PivotalClient instance is called
  before do
    session[:api_token] = api_token 
    @pivotal_stub = double(set_token: nil)
    subject.stub(:pivotal).and_return(@pivotal_stub)
  end

  let(:project) { double(id: '123') }
  let(:stories) { [] }

  context 'known project and stream' do
    before do
      @pivotal_stub.stub(fetch_project: project)
      @pivotal_stub.stub(fetch_stories: stories)
    end

    it 'renders the stream template' do
      xhr :get, :show, id: '1', stream_name: 'todo'
      expect(response).to render_template('_stream')
    end

    context 'no api token' do
      it 'returns 401 unauthorized' do
        session[:api_token] = nil
        xhr :get, :show, id: '1', stream_name: 'todo'
        response.code.should eq '401'
      end
    end

  end

end

