require 'rails_helper'

describe 'As a user on my dashboard page' do
  it 'I see a list of my bookmarked segments' do
    # VCR.use_cassette('see_ordered_bookmarks', record: :new_episodes) do
      WebMock.allow_net_connect!
      VCR.turn_off!

      user = create(:user)
      tutorial1 = create(:tutorial, title: 'How to Tie Your Shoes')
      tutorial2 = create(:tutorial, title: 'Prework - Environment Setup')
      tutorial3 = create(:tutorial, title: 'Mod 3')

      video1 = create(:video, tutorial_id: tutorial1.id, title: 'The Bunny Ears Technique')
      video2 = create(:video, tutorial_id: tutorial2.id, title: 'Bundle Install')
      video3 = create(:video, tutorial_id: tutorial3.id, title: 'Rails Integration Testing')

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      # As a logged in user
      visit tutorial_path(tutorial1)

      expect do
        click_on 'Bookmark'
      end.to change { UserVideo.count }.by(1)

      visit tutorial_path(tutorial2)

      expect do
        click_on 'Bookmark'
      end.to change { UserVideo.count }.by(1)

      visit tutorial_path(tutorial3)

      expect do
        click_on 'Bookmark'
      end.to change { UserVideo.count }.by(1)

      # When I visit '/dashboard'
      visit '/dashboard'
      # Then I should see a list of all bookmarked segments under the Bookmarked Segments section
      # And they should be organized by which tutorial they are a part of
      # And the videos should be ordered by their position

      within(page.first('.bookmarked_segments')) do
        expect(page).to have_content(video1.title)
        expect(page).to_not have_content(video2.title)
        expect(page).to_not have_content(video3.title)
      end

      within(page.all('.bookmarked_segments')[1]) do
        expect(page).to have_content(video2.title)
        expect(page).to_not have_content(video1.title)
        expect(page).to_not have_content(video3.title)
      end

      within(page.all('.bookmarked_segments')[2]) do
        expect(page).to have_content(video3.title)
        expect(page).to_not have_content(video2.title)
        expect(page).to_not have_content(video1.title)
      end
    #end
  end
end
