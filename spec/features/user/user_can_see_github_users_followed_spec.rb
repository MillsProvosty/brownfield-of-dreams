require 'rails_helper'

describe "As a user on my dashboard page" do
  it "I see a list of github users I'm following" do
    VCR.use_cassette('user_gitub_users_followed') do
    # WebMock.allow_net_connect!
    # VCR.turn_off!
      user = create(:user)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit '/dashboard'

      # save_and_open_page

      within("#github_followed_users") do
        expect(page).to have_content("Users Followed")

        expect(page.all(".followed_user_list").count).to eq(5)
        within(first(".followed_user_list")) do
          expect(page).to have_link("Mycobee")
        end
      end
    end
  end
end
