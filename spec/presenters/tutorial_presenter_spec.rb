# frozen_string_literal: true

require 'rails_helper'
describe TutorialFacade do
  describe 'instance methods' do
    it 'can find the current video' do
      tutorial = create(:tutorial)
      create(:video, tutorial: tutorial)
      video2 = create(:video, tutorial: tutorial)
      create(:video, tutorial: tutorial)

      presenter = TutorialFacade.new(tutorial, video2.id)

      expect(presenter.current_video.id).to eq(video2.id)
    end

    it 'uses first video if video id not present' do
      tutorial = create(:tutorial)
      video1 = create(:video, tutorial: tutorial)
      create(:video, tutorial: tutorial)
      create(:video, tutorial: tutorial)

      presenter = TutorialFacade.new(tutorial)

      expect(presenter.current_video.id).to eq(video1.id)
    end

    context '#next_video' do
      it 'can find the next video' do
        tutorial = create(:tutorial)
        video1 = create(:video, tutorial: tutorial, position: 1)
        video2 = create(:video, tutorial: tutorial, position: 2)
        create(:video, tutorial: tutorial, position: 3)

        presenter = TutorialFacade.new(tutorial, video1.id)

        expect(presenter.next_video).to eq(video2)
      end

      it 'returns last video if the current video is the last in the list' do
        tutorial = create(:tutorial)
        create(:video, tutorial: tutorial, position: 1)
        last_video = create(:video, tutorial: tutorial, position: 2)

        presenter = TutorialFacade.new(tutorial, last_video.id)
        expect(presenter.next_video).to eq(last_video)
      end
    end
  end
end
