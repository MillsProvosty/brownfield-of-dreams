require 'rails_helper'

describe "As a user on my dashboard page" do
  it "I see a button to login to github" do
    #VCR.use_cassette('github_auth', :record => :new_episodes) do
      WebMock.allow_net_connect!
      VCR.turn_off!


      user1 = create(:user_with_github)
      user2 = create(:user_with_github, github_handle: "kylecornelissen", github_url: "https://github.com/kylecornelissen")
      user3 = create(:user_with_github, github_handle: "m-mrcr", github_url: "https://github.com/m-mrcr")

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user1)

      visit '/dashboard'

      within(first(".follower_list")) do
        click_button "Add as Friend"
      end

      within(page.all(".follower_list")[1]) do
        expect(page).to_not have_button("Add as Friend")
      end

      expect(page).to have_content("My Friends")

      within(first(".friend_list")) do
        expect(page).to have_link("kylecornelissen")
      end

      within(first(".follower_list")) do
        expect(page).to_not have_button("Add as Friend")
      end

      #followed
      within(first(".followed_user_list")) do
        click_button "Add as Friend"
      end

      within(page.all(".friend_list")[1]) do
        expect(page).to have_link("m-mrcr")
      end

      within(page.all(".followed_user_list")[1]) do
        expect(page).to_not have_button("Add as Friend")
      end

      within(first(".followed_user_list")) do
        expect(page).to_not have_button("Add as Friend")
      end

    #end
  end
end
