# frozen_string_literal: true

require 'rails_helper'

describe 'As a registered user (authorized with github) on my dashboard page' do
  before(:each) do
    user = create(:user_with_github)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  end

  it 'I can invite a github user with a public email' do
    VCR.use_cassette('invite_github_user', record: :new_episodes) do
      visit '/dashboard'
      click_link 'Send an Invite'

      expect(current_path).to eq('/invite')

      fill_in :github_handle, with: 'chakeresa'
      expect do 
        click_button 'Send Invite'
        sleep 1
      end.to change { ActionMailer::Base.deliveries.count }.by(1)

      expect(current_path).to eq('/dashboard')
      expect(page).to have_content('Successfully sent invite!')
    end
  end

  it 'I cannot invite a github user with a private email' do
    VCR.use_cassette('invite_private_github_user', record: :new_episodes) do
      visit '/dashboard'
      click_link 'Send an Invite'

      fill_in :github_handle, with: 'kylecornelissen'
      expect do
        click_button 'Send Invite'
        sleep 1
      end.to change { ActionMailer::Base.deliveries.count }.by(0)

      expect(current_path).to eq('/dashboard')
      expect(page).to have_content("The Github user you selected doesn't have an email address associated with their account.")
    end
  end

  it 'I see a message if I enter an invalid github handle' do
    VCR.use_cassette('invite_invalid_github_handle', record: :new_episodes) do
      visit '/dashboard'
      click_link 'Send an Invite'

      invitee_handle = 'MillsProvosty111'

      fill_in :github_handle, with: invitee_handle
      expect do
        click_button 'Send Invite'
        sleep 1
      end.to change { ActionMailer::Base.deliveries.count }.by(0)

      expect(current_path).to eq('/dashboard')
      expect(page).to have_content("Failed to find the Github user with handle #{invitee_handle}")
    end
  end
end

describe 'As a registered user (not authorized with github) on my dashboard page' do
  it 'I cannot invite a github user' do
    VCR.use_cassette('no_invite_button_for_non_github_user', record: :new_episodes) do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit '/dashboard'

      expect(page).to_not have_link('Send an Invite')
    end
  end
end
