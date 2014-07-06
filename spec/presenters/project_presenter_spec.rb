require 'rails_helper'

describe ProjectPresenter do
  before { Timecop.freeze }
  after { Timecop.return }
  
  let(:today_story) { OpenStruct.new(accepted_at: Time.now) }
  let(:yesterday_story) { OpenStruct.new(accepted_at: 1.day.ago) }

  let(:subject) { ProjectPresenter.new(nil, '123') }

  describe '#each_story' do
#    let(:stream) { OpenStruct.new(name: 'StoryName', stories: stories) }

    def expect_each_story_to_have_successive_yields_with(*successive_args)
      expect do |b|
        subject.each_story('a stream', stories, &b)
      end.to yield_successive_args(*successive_args)
    end

    context 'stream shows date bars' do
      before { subject.stub(stream_shows_date_bars?: true) }

      context 'day changes' do
        let(:stories) { [today_story, yesterday_story] }

        it 'shows a date bar' do
          expect_each_story_to_have_successive_yields_with(
            # first day is always a new day
            [anything, true],
            [anything, true]
          )
        end
      end

      context 'same day' do
        let(:stories) { [yesterday_story, yesterday_story] }

        it 'does not show a date bar' do
          expect_each_story_to_have_successive_yields_with(
            # first day is always a new day
            [anything, true],
            [anything, false]
          )
        end
      end
    end

    context 'stream does not show date bars' do
      before { subject.stub(stream_shows_date_bars?: false) }
      let(:stories) { [today_story, yesterday_story] }

      it 'show_date_bar is false for all yields' do
        expect_each_story_to_have_successive_yields_with(
          [anything, false],
          [anything, false]
        )
      end
    end
  end

  describe '#same_day?' do
    specify { subject.same_day?(nil, today_story).should == false}
    specify { subject.same_day?(today_story, nil).should == false }
    specify { subject.same_day?(today_story, today_story).should == true }
    specify { subject.same_day?(today_story, yesterday_story).should == false }
  end

  describe '#stream_shows_date_bars?' do
    it 'shows date bar if stream is called :done' do
      subject.stream_shows_date_bars?(:done).should == true
    end

    it 'does not show date bar if stream is not called :in_progress' do
      subject.stream_shows_date_bars?(:in_progress).should == false
    end

    it 'does not show date bar if stream is not called :todo' do
      subject.stream_shows_date_bars?(:todo).should == false
    end
  end

end

