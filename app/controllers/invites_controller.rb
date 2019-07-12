class InvitesController < ApplicationController
  def new; end

  def create
    inviter_handle = current_user.github_handle
    invitee_handle = params[:github_handle]
    inviter_attributes = github_service.user_attributes(inviter_handle)
    invitee_attributes = github_service.user_attributes(invitee_handle)
    if invitee_attributes.has_key?(:message)
      flash[:danger] = "Failed to find the Github user with handle #{invitee_handle}"
    else
      invitee_email = invitee_attributes[:email]
      if invitee_email
        inviter_name = inviter_attributes[:name]
        invitee_name = invitee_attributes[:name]
        UserMailer.invite_email(inviter_name, invitee_name, invitee_email).deliver_later
        flash[:success] = 'Successfully sent invite!'
      else
        flash[:danger] = "The Github user you selected doesn't have an email address associated with their account."
      end
    end
    redirect_to dashboard_path
  end

  private

  def github_service
    @github_service ||= GithubApiService.new(current_user.github_token)
  end
end
