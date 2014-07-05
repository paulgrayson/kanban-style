require 'rails_helper'

describe Streamer do

  let(:project) { OpenStruct.new(id: '1') }
  let(:pivotal_stub) { double }
  let(:streamer) { Streamer.new(pivotal_stub, project) }

  describe :done do
    xit 'only fetches stories completed in the last 3 days' do
      pivotal_stub.should_receive(:fetch_stories).with(project, hash_including(accepted_at: '-3d'))
      streamer.done
    end

    it 'only fetches stories that have been accepted' do
      pivotal_stub.should_receive(:fetch_stories).with(project, hash_including(current_state: 'accepted'))
      streamer.done
    end

    it 'sorts so that most recently accepted is first'
  end

  describe :in_progress do
    it 'only fetches stories that have been started, finished, delivered or rejected' do
      pivotal_stub.should_receive(:fetch_stories).with(project, hash_including(current_state: 'started,finished,delivered,rejected'))
      streamer.in_progress
    end
  end

  describe :todo do
    it 'only fetches stories that are unstarted in the backlog' do
      # unstarted is pivotal state for being in the backlog (not icebox, they are unscheduled)
      pivotal_stub.should_receive(:fetch_stories).with(project, hash_including(current_state: 'unstarted'))
      streamer.todo
    end
  end

end

