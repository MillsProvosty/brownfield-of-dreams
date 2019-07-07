require 'rails_helper'

describe "As a user on my dashboard page" do
  it "I see a button to login to github" do
    #VCR.use_cassette('github_auth', :record => :new_episodes) do
      WebMock.allow_net_connect!
      VCR.turn_off!


      user1 = create(:user_with_github)
      user2 = create(:user_with_github, github_handle: "kylecornelissen", github_url: "https://github.com/kylecornelissen")


      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user1)

      visit '/dashboard'
      save_and_open_page



    #end
  end
end
