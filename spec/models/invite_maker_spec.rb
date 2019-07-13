# frozen_string_literal: true

require 'rails_helper'

RSpec.describe InviteMaker, type: :model do
  before(:each) do
    @current_user = double('current_user')
    allow(@current_user).to receive(:github_handle).and_return('kylecornelissen')
    allow(@current_user).to receive(:github_token).and_return(ENV['GITHUB_API_KEY'])
  end

  it 'exists' do
    invite_maker = InviteMaker.new(@current_user, 'kyle')
    expect(invite_maker).to be_a(InviteMaker)
    expect(invite_maker.flash).to eq(nil)
  end

  describe '#setup_email' do
    it 'sends email when invitee_handle is a valid github handle and the user has a public email' do
      VCR.use_cassette('invite_maker_valid_github_handle', record: :new_episodes) do
        invite_maker = InviteMaker.new(@current_user, 'chakeresa')
        expected_flash = { success: 'Successfully sent invite!' }

        expect do
          invite_maker.setup_email
          sleep 1
        end.to change { ActionMailer::Base.deliveries.count }.by(1)

        expect(invite_maker.flash).to eq(expected_flash)
      end
    end

    it 'does not send email when invitee_handle is a valid github handle but the user has a private email' do
      VCR.use_cassette('invite_maker_github_handle_with_private_email', record: :new_episodes) do
        invite_maker = InviteMaker.new(@current_user, 'MillsProvosty')
        expected_flash = { danger: "The Github user you selected doesn't have an email address associated with their account." }

        expect do
          invite_maker.setup_email
          sleep 1
        end.to change { ActionMailer::Base.deliveries.count }.by(0)

        expect(invite_maker.flash).to eq(expected_flash)
      end
    end

    it 'does not send email when invitee_handle is not a valid github handle' do
      VCR.use_cassette('invite_maker_invalid_github_handle', record: :new_episodes) do
        bad_handle = 'MillsProvosty1111'
        invite_maker = InviteMaker.new(@current_user, bad_handle)
        expected_flash = { danger: "Failed to find the Github user with handle #{bad_handle}" }

        expect do
          invite_maker.setup_email
          sleep 1
        end.to change { ActionMailer::Base.deliveries.count }.by(0)

        expect(invite_maker.flash).to eq(expected_flash)
      end
    end
  end
end
