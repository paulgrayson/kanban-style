require 'rails_helper'

describe StreamController do

  # ensure no method on any PivotalClient instance is called
  before do
    @pivotal_stub = double
    subject.stub(:pivotal).and_return(@pivotal_stub)
  end

  let(:project) { double(id: '123') }
  let(:stories) { [] }

  context 'known project and stream' do
    it 'renders the stream template' do
      @pivotal_stub.stub(fetch_project: project)
      @pivotal_stub.stub(fetch_stories: stories)
      get :show, id: '1', stream_name: 'todo'
      expect(response).to render_template('_stream')
    end
  end

end

