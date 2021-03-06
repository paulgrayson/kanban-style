require 'features/features_helper'

feature "viewing a project board" do

  let(:page) { Pages::Project.new }

  let(:project) do
    OpenStruct.new(
      id: 123,
      name: 'KanbanStyle'
    )
  end

  let :stories do
    [
      OpenStruct.new(
        name: 'Story #1',
        accepted_at: 10.minutes.ago
      ),
      OpenStruct.new(
        name: 'Story #2',
        accepted_at: 1.day.ago
      )
    ]
  end

  before do
    PivotalClient.any_instance.stub(fetch_project: project)
    PivotalClient.any_instance.stub(fetch_stories: stories)
  end

  scenario "shows project name and loads some stories for each stream", js: true do
    page.pretend_signed_in
    page.open project.id
    page.project_name.should == project.name
    page.stream_names.should contain_exactly('Done', 'In progress', 'Todo')
    page.stories(stream: :done).length.should > 0
    page.stories(stream: :in_progress).length.should > 0
    page.stories(stream: :todo).length.should > 0
  end

end

