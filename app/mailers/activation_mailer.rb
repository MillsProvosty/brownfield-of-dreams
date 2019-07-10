class ActivationMailer < ApplicationMailer

  def register(user)
    @user = user
    mail(to: user.email, subject: "Activate Your Account")
  end
end
