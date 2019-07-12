# frozen_string_literal: true

class UserMailer < ApplicationMailer
  def activation_email(user)
    @user = user
    mail(to: user.email, subject: 'Activate Your Account')
  end

  def invite_email(inviter_name, invitee_name, invitee_email)
    @inviter_name = inviter_name
    @invitee_name = invitee_name
    mail(to: invitee_email, subject: 'Join Brownfield of Dreams!')
  end
end
