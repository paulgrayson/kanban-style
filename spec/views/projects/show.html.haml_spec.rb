require 'rails_helper'

describe 'projects/show.html.haml' do

  let(:presenter) { ProjectPresenter.new(nil) }
  let(:project) { OpenStruct.new(id: '123', name: 'Project Name') }
  let(:streams) { {done: [first_story]} }
  
  let(:first_story) do
    OpenStruct.new(
      name: 'First Story',
      accepted_at: Time.now,
      url: 'http://pivotaltracker.com/story/123'
    )
  end

  before do
    presenter.stub(project: project, streams: streams)
    assign(:presenter, presenter)
  end

  it 'hyperlinks story names to their pivotal url' do
    render
    rendered.should have_selector('.story a', text: first_story.name)
    rendered.should have_selector('.story a[href]', exact: first_story.url)
  end

end

