# frozen_string_literal: true

require 'rails_helper'

describe 'visitor can only see public tutorials', :js do
  it 'unless they are logged in' do
    VCR.use_cassette('visitor_no_clasroom_tutorials', record: :new_episodes) do
      tutorial1 = create(:tutorial, classroom: false)
      tutorial2 = create(:tutorial, classroom: true)

      video1 = create(:video, tutorial_id: tutorial1.id)
      video2 = create(:video, tutorial_id: tutorial1.id)
      video3 = create(:video, tutorial_id: tutorial2.id)
      video4 = create(:video, tutorial_id: tutorial2.id)

      visit root_path

      expect(page).to have_css('.tutorial', count: 1)

      within(first('.tutorials')) do
        expect(page).to have_css('.tutorial')
        expect(page).to have_css('.tutorial-description')
        expect(page).to have_content(tutorial1.title)
        expect(page).to have_content(tutorial1.description)
      end

      expect(page).to_not have_content(tutorial2.title)
      expect(page).to_not have_content(tutorial2.description)
    end
  end
end
