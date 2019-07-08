# frozen_string_literal: true

require 'rails_helper'

describe 'As a user on my dashboard page' do
  it 'I see a list of my github repos' do
    VCR.use_cassette('user_repos', record: :new_episodes) do
      user = create(:user_with_github)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit '/dashboard'

      within('#github') do
        expect(page).to have_content('Github')
        expect(page).to have_content('Repos')
        expect(page.all('.repo_list').count).to eq(5)
        within(first('.repo_list')) do
          expect(page).to have_link('brownfield-of-dreams')
        end
      end
    end
  end
end
