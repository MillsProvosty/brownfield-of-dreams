# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserMailer, type: :mailer do
  describe 'activation email after registration' do
    before :each do
      @user = create(:user)
      @mail = UserMailer.activation_email(@user)
    end

    it 'renders the headers' do
      expect(@mail.subject).to eq('Activate Your Account')
      expect(@mail.to).to eq([@user.email])
      expect(@mail.from).to eq(['no_reply@brownfieldofdreams.com'])
    end

    it 'renders the body' do
      expect(@mail.body.encoded).to match('Visit here to activate your account.')
    end
  end

  describe 'invite email to a github user' do
    before :each do
      @inviter_name = 'Mills Provosty'
      @invitee_name = 'Alexandra Chakeres'
      @invitee_email = 'test@example.com'
      @mail = UserMailer.invite_email(@inviter_name, @invitee_name, @invitee_email)
    end

    it 'renders the headers' do
      expect(@mail.subject).to eq('Join Brownfield of Dreams!')
      expect(@mail.to).to eq([@invitee_email])
      expect(@mail.from).to eq(['no_reply@brownfieldofdreams.com'])
    end

    it 'renders the body' do
      expect(@mail.body.encoded).to have_content("Hello #{@invitee_name},")
      expect(@mail.body.encoded).to have_content("#{@inviter_name} has invited you to join Brownfield of Dreams. You can create an account here.")
    end
  end
end
