require 'rails_helper'

describe 'As a user on my dashboard page' do
  it 'I see a list of my github repos' do
    # VCR.use_cassette('see_ordered_bookmarks', record: :new_episodes) do
      WebMock.allow_net_connect!
      VCR.turn_off!

      user = create(:user)
      tutorial1 = create(:tutorial)
      tutorial2 = create(:tutorial)
      tutorial3 = create(:tutorial)

      video1 = create(:video, tutorial_id: tutorial1.id)
      video2 = create(:video, tutorial_id: tutorial2.id)
      video3 = create(:video, tutorial_id: tutorial3.id)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit '/dashboard'

      expect(page).to have_content("Bookmarked Segments")

      within(page.first('.bookmarks-btn')) do
        expect(page).to have_content(video1)
        expect(page).to_not have_content(video2)
        expect(page).to_not have_content(video3)
      end

      within(page.all('.bookmarks-btn')[1]) do
        expect(page).to have_content(video2)
        expect(page).to_not have_content(video1)
        expect(page).to_not have_content(video3)
      end

      within(page.all('.bookmarks-btn')[2]) do
        expect(page).to have_content(video3)
        expect(page).to_not have_content(video2)
        expect(page).to_not have_content(video1)
      end
    #end
  end
end
