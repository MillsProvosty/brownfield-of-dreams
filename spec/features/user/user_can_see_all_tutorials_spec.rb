# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'As a logged in user' do
  it 'I can see all tutorials.' do
    VCR.use_cassette('user_sees_all_tutorials', record: :new_episodes) do
      tutorial1 = create(:tutorial, classroom: false)
      tutorial2 = create(:tutorial, classroom: true)

      create(:video, tutorial_id: tutorial1.id)
      create(:video, tutorial_id: tutorial1.id)
      create(:video, tutorial_id: tutorial2.id)
      create(:video, tutorial_id: tutorial2.id)

      user = create(:user)

      allow_any_instance_of(ApplicationController)
        .to receive(:current_user).and_return(user)

      visit root_path

      expect(page).to have_css('.tutorial', count: 2)

      within(first('.tutorials')) do
        expect(page).to have_css('.tutorial')
        expect(page).to have_css('.tutorial-description')
        expect(page).to have_content(tutorial1.title)
        expect(page).to have_content(tutorial1.description)
      end

      expect(page).to have_content(tutorial2.title)
      expect(page).to have_content(tutorial2.description)
    end
  end
end
