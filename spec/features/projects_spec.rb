require 'features/features_helper'

feature "view the projects list" do

  let(:page) { Pages::Projects.new }

  let(:projects) do
    [
      OpenStruct.new(id: 1, name: 'P1'),
      OpenStruct.new(id: 2, name: 'P2'),
      OpenStruct.new(id: 3, name: 'P3')
    ]
  end

  before do
    PivotalClient.any_instance.stub(fetch_projects: projects)
  end

  scenario "shows list of projects associated with pivotal account", js: true do
    page.open
    page.projects.should contain_exactly(*projects.map(&:name))
  end

end

