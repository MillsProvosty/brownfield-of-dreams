# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'As a non-activated user' do
  include ActionMailer::TestHelper
  describe 'When I click the link in my activation email' do
    before :each do
      email = 'jimbob@aol.com'
      first_name = 'Jim'
      last_name = 'Bob'
      password = 'password'
      password_confirmation = 'password'

      visit new_user_path

      fill_in 'user[email]', with: email
      fill_in 'user[first_name]', with: first_name
      fill_in 'user[last_name]', with: last_name
      fill_in 'user[password]', with: password
      fill_in 'user[password_confirmation]', with: password

      click_on 'Create Account'
      visit activate_user_path(User.last.id)
    end

    it 'I should be taken to an activation page' do
      VCR.use_cassette('activation_page', record: :new_episodes) do
        expect(page).to have_content('Thank you! Your account is now activated.')
      end
    end

    it 'when I visit dashboard, I should see status active' do
      VCR.use_cassette('dashboard_after_activation', record: :new_episodes) do
        visit dashboard_path
        expect(page).to have_content('Status: Active')
      end
    end
  end
end
