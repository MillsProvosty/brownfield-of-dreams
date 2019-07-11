class InvitesController < ApplicationController
  def new; end

  def create
    UserMailer.invite_email(inviter, invitee)
    flash[:success] = 'Successfully sent invite!'
    redirect_to dashboard_path
  end
end
