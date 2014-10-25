require 'rails_helper'

describe PivotalClient do

  let(:stories) { double(:all) }
  let(:project) { double(stories: stories) }

  it 'quotes multi-word labels' do
    stories.should_receive(:all).with(hash_including(label: ['"multi word"']))
    subject.fetch_stories(project, label: 'multi word')
  end

end

