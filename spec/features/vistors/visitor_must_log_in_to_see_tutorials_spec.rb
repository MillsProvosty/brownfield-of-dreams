# frozen_string_literal: true

require 'rails_helper'

describe 'visitor cannot see tutorials', :js do
  it 'until they have logged in, and they are classroom content' do
    # VCR.use_cassette('visitor_no_tutorials', record: :new_episodes) do
      WebMock.allow_net_connect!
      VCR.turn_off!

      tutorial1 = create(:tutorial, classroom: true)
      tutorial2 = create(:tutorial, classroom: false)

      video1 = create(:video, tutorial_id: tutorial1.id)
      video2 = create(:video, tutorial_id: tutorial1.id)
      video3 = create(:video, tutorial_id: tutorial2.id)
      video4 = create(:video, tutorial_id: tutorial2.id)

      visit root_path

      expect(page).to_not have_css('.tutorial', count: 2)


      expect(page).to_not have_css('.tutorial')
      expect(page).to_not have_css('.tutorial-description')
      expect(page).to_not have_content(tutorial1.title)
      expect(page).to_not have_content(tutorial1.description)
    # end
  end

  it 'can only see tutorials once logged in and the content is marked classroom. ' do
    # VCR.use_cassette('visitor_see_tutorials', record: :new_episodes) do
      WebMock.allow_net_connect!
      VCR.turn_off!

      tutorial1 = create(:tutorial, classroom: true)
      tutorial2 = create(:tutorial, classroom: false)

      video1 = create(:video, tutorial_id: tutorial1.id)
      video2 = create(:video, tutorial_id: tutorial1.id)
      video3 = create(:video, tutorial_id: tutorial2.id)
      video4 = create(:video, tutorial_id: tutorial2.id)

      user = create(:user)

      visit '/'

      click_on 'Sign In'

      expect(current_path).to eq(login_path)

      fill_in 'session[email]', with: user.email
      fill_in 'session[password]', with: user.password

      click_on 'Log In'

      expect(current_path).to eq(dashboard_path)

      visit root_path

       expect(page).to have_css('.tutorial', count: 1)

      within(first('.tutorials')) do
        expect(page).to have_css('.tutorial')
        expect(page).to have_css('.tutorial-description')
        expect(page).to have_content(tutorial1.title)
        expect(page).to have_content(tutorial1.description)
      end

      within(page.all('.tutorials')[1]) do
        expect(page).to have_css('.tutorial')
        expect(page).to have_css('.tutorial-description')
        expect(page).to have_content(tutorial1.title)
        expect(page).to have_content(tutorial1.description)
      end

      within(page.all('.tutorials')[2]) do
        expect(page).to_not have_css('.tutorial')
        expect(page).to_not have_css('.tutorial-description')
        expect(page).to_not have_content(tutorial2.title)
        expect(page).to_not have_content(tutorial2.description)
      end

      within(page.all('.tutorials')[3]) do
        expect(page).to_not have_css('.tutorial')
        expect(page).to_not have_css('.tutorial-description')
        expect(page).to_not have_content(tutorial2.title)
        expect(page).to_not have_content(tutorial2.description)
      end
    # end
  end
end
