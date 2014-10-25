require 'rails_helper'

describe Streamer do

  let(:project) { OpenStruct.new(id: '1') }
  let(:pivotal_stub) { double }
  let(:streamer) { Streamer.new(pivotal_stub, project, filters) }

  context 'with no filters' do
    let(:filters) { nil }

    describe '#done' do
      xit 'only fetches stories completed in the last 3 days' do
        pivotal_stub.should_receive(:fetch_stories).with(project, hash_including(accepted_at: '-3d'))
        streamer.done
      end

      it 'only fetches stories that have been accepted' do
        pivotal_stub.should_receive(:fetch_stories).with(project, hash_including(current_state: 'accepted'))
        streamer.done
      end

      it 'sorts so that most recently accepted is first' do
        now = Time.now
        first, second, third = double(accepted_at: now), double(accepted_at: now - 1.hour ), double(accepted_at: now - 2.hours)
        pivotal_stub.stub(fetch_stories: [third, first, second])
        streamer.done.should eq [first, second, third]
      end
    end

    describe '#in_progress' do
      it 'only fetches stories that have been started, finished, delivered or rejected' do
        pivotal_stub.should_receive(:fetch_stories).with(project, hash_including(current_state: 'started,finished,delivered,rejected'))
        streamer.in_progress
      end
    end

    describe '#todo' do
      it 'only fetches stories that are unstarted in the backlog' do
        # unstarted is pivotal state for being in the backlog (not icebox, they are unscheduled)
        pivotal_stub.should_receive(:fetch_stories).with(project, hash_including(current_state: 'unstarted'))
        streamer.todo
      end
    end
  end

  context 'with label filter' do
    let(:filters) { {label: 'merged'} }

    def should_include_filters_when_fetching_stream(stream)
      pivotal_stub.should_receive(:fetch_stories).with(project, hash_including(filters))
      streamer.send(stream)
    end

    it { should_include_filters_when_fetching_stream(:done) }
    it { should_include_filters_when_fetching_stream(:in_progress) }
    it { should_include_filters_when_fetching_stream(:todo) }
  end

end

