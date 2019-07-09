# frozen_string_literal: true

require 'rails_helper'

describe 'visitor visits tutorial show page' do
  it 'sees a list of videos associated with that tutorial' do
    tutorial = create(:tutorial)
    video_1, video_2 = create_list(:video, 2, tutorial: tutorial)

    visit "/tutorials/#{tutorial.id}"

    within('#video-list') do
      expect(page.all('.show-link').count).to eq(2)
      expect(first('.show-link')).to have_content(video_1.title)
    end
  end

  it 'does not error out when there are no videos for the tutorial' do
    tutorial = create(:tutorial)

    visit "/tutorials/#{tutorial.id}"

    expect(page.all('.show-link').count).to eq(0)
    expect(page).to have_content('This tutorial has no videos')
  end
end
