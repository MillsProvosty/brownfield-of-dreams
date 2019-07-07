require 'rails_helper'

describe "As a user on my dashboard page" do
  it "next to Github users with accounts, I see a 'add as friend' button" do
    VCR.use_cassette('github_auth', :record => :new_episodes) do
      mock_oauth

      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit '/dashboard'

      expect(page).to have_button("Add as Friend")

      OmniAuth.config.mock_auth[:github] = nil
    end
  end
end
