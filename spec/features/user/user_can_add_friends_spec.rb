require 'rails_helper'

describe "As a user on my dashboard page" do
  it "I see a button to add friends next to followers and followed users" do
    VCR.use_cassette('github_add_friend', :record => :new_episodes) do
      user1 = create(:user_with_github)
      user2 = create(:user_with_github, github_handle: "kylecornelissen", github_url: "https://github.com/kylecornelissen")
      user3 = create(:user_with_github, github_handle: "m-mrcr", github_url: "https://github.com/m-mrcr")

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user1)

      visit '/dashboard'

      within(first(".follower_list")) do
        click_button "Add as Friend"
      end

      expect(page).to have_content("#{user2.github_handle} added as a friend")

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

      expect(page).to have_content("#{user3.github_handle} added as a friend")

      within(page.all(".friend_list")[1]) do
        expect(page).to have_link("m-mrcr")
      end

      within(page.all(".followed_user_list")[1]) do
        expect(page).to_not have_button("Add as Friend")
      end

      within(first(".followed_user_list")) do
        expect(page).to_not have_button("Add as Friend")
      end
    end
  end

  it "I get an error message when I try to add someone I'm already friends with" do
    VCR.use_cassette('github_already_friend', :record => :new_episodes) do

      user1 = create(:user_with_github)
      user2 = create(:user_with_github, github_handle: "kylecornelissen", github_url: "https://github.com/kylecornelissen")

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user1)

      visit '/dashboard'

      user1.friendships.create(friend: user2)

      within(first(".follower_list")) do
        click_button "Add as Friend"
      end

      expect(page).to have_content("#{user2.github_handle} is already your friend")

    end
  end

  it "I get an error message when I try to add someone who isn't a registered user" do
    VCR.use_cassette('github_user_not_registered', :record => :new_episodes) do

      user1 = create(:user_with_github)
      user2 = create(:user_with_github, github_handle: "kylecornelissen", github_url: "https://github.com/kylecornelissen")

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user1)

      visit '/dashboard'

      user2.destroy

      within(first(".follower_list")) do
        click_button "Add as Friend"
      end

      expect(page).to have_content("#{user2.github_handle} is not a registered user")

    end
  end


end
