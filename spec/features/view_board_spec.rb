require 'features/features_helper'

feature "viewing a projects board" do

  let :page do
    Pages::Board.new
  end

  let :project do
    OpenStruct.new(
      id: 123,
      name: 'KanbanStyle'
    )
  end

  let :stories do
    [
      OpenStruct.new(
        name: 'Story #1'
      ),
      OpenStruct.new(
        name: 'Story #2'
      )
    ]
  end

  scenario "I can see the project name and some stories" do
    # Scenario: I can see the project name and some stories
    # Given a pivotal project with some stories
    # When I view the project's board
    # Then I see the projects name
    # And I see some stories
    PivotalClient.any_instance.stub(fetch_project: project)
    PivotalClient.any_instance.stub(fetch_stories: stories)
    page.open project.id
    page.project_name.should == project.name
    page.stories.length.should > 0
  end

end

