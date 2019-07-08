# frozen_string_literal: true

require 'rails_helper'

describe 'As a user on my dashboard page' do
  it 'I see a list of my github followers' do
    VCR.use_cassette('user_followers', record: :new_episodes) do
      user = create(:user_with_github)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit '/dashboard'

      within('#github_followers') do
        expect(page).to have_content('Followers')
        expect(page.all('.follower_list').count).to eq(7)
        within(first('.follower_list')) do
          expect(page).to have_link('kylecornelissen')
        end
      end
    end
  end
end
