require 'rails_helper'

describe 'As a user on my dashboard page' do
  it 'I see a list of my bookmarked videos' do
     VCR.use_cassette('see_ordered_bookmarks', record: :new_episodes) do

      user = create(:user)

      tutorial1 = create(:tutorial)
      tutorial2 = create(:tutorial)
      tutorial3 = create(:tutorial)

      video11 = create(:video, tutorial_id: tutorial1.id)
      video21 = create(:video, tutorial_id: tutorial2.id)
      video31 = create(:video, tutorial_id: tutorial3.id, position: 2)
      video32 = create(:video, tutorial_id: tutorial3.id, position: 1)
      create(:video, tutorial_id: tutorial3.id, position: 3)

      user_video11 = create(:user_video, user: user, video: video11)
      user_video21 = create(:user_video, user: user, video: video21)
      user_video31 = create(:user_video, user: user, video: video31)
      user_video32 = create(:user_video, user: user, video: video32)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit '/dashboard'
save_and_open_page
      within(page.first('.tutorial_list')) do
        expect(page).to have_link(tutorial1.title)
        expect(page).to have_link(video11.title)
        expect(page).to_not have_link(video21.title)
        expect(page).to_not have_link(video31.title)
        expect(page).to_not have_link(video32.title)
      end

      within(page.all('.tutorial_list')[1]) do
        expect(page).to have_link(tutorial2.title)
        expect(page).to have_link(video21.title)
        expect(page).to_not have_link(video11.title)
        expect(page).to_not have_link(video31.title)
        expect(page).to_not have_link(video32.title)
      end

      within(page.all('.tutorial_list')[2]) do
        expect(page).to have_link(tutorial3.title)
        expect(page).to have_link(video32.title)
        expect(page).to have_link(video31.title)
        expect(page).to_not have_link(video11.title)
        expect(page).to_not have_link(video21.title)
      end
    end
  end
end
