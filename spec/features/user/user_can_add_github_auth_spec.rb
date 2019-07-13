# frozen_string_literal: true

require 'rails_helper'

describe 'As a user on my dashboard page' do
  it 'I see a button to login to github' do
    VCR.use_cassette('github_auth', record: :new_episodes) do
      mock_oauth

      user = create(:user)
      allow_any_instance_of(ApplicationController)
      .to receive(:current_user).and_return(user)

      visit '/dashboard'

      expect(page).to_not have_link('brownfield-of-dreams')

      click_link 'Connect to Github'

      within(first('.repo_list')) do
        expect(page).to have_link('brownfield-of-dreams')
      end

      OmniAuth.config.mock_auth[:github] = nil
    end
  end
end
