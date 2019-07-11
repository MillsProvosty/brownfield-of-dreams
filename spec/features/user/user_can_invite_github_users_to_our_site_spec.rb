# frozen_string_literal: true

require 'rails_helper'

describe 'As a registered user on my dashboard page' do
  it 'I can invite a github user' do
    # VCR.use_cassette('invite_github_user', record: :new_episodes) do
      WebMock.allow_net_connect!
      VCR.turn_off!

      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit '/dashboard'
      click_link 'Send an Invite'

      expect(current_path).to eq('/invite')
      
      fill_in 'some field', with: 'kylecornelissen'
      click_button 'Send Invite'

      expect(current_path).to eq('/dashboard')
      expect(page).to have_content('Successfully sent invite!')
    # end
  end

# Background: We want to be able to enter a user's Github handle and send them an email invite to our app. You'll use the Github API to retrieve the email address of the invitee.
# Or I should see a message that says "The Github user you selected doesn't have an email address associated with their account."
