# frozen_string_literal: true

require 'rails_helper'

describe 'As a user on my dashboard page' do
  it "I see a list of github users I'm following" do
    VCR.use_cassette('user_followings', record: :new_episodes) do
      user = create(:user_with_github)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit '/dashboard'

      within('#github_followed_users') do
        expect(page).to have_content('Following')
        expect(page.all('.followed_user_list').count).to eq(6)
        within(first('.followed_user_list')) do
          expect(page).to have_link('earl-stephens')
        end
      end
    end
  end
end
