class UserMailer < ApplicationMailer
  def activation_email(user)
    @user = user
    mail(to: user.email, subject: 'Activate Your Account')
  end

  def invite_email(inviter, invitee)
    @inviter = inviter
    @invitee = invitee
    mail(to: @invitee.email, subject: 'Join Brownfield of Dreams!')
  end
end
