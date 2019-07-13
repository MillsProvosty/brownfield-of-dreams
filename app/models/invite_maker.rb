# frozen_string_literal: true

class InviteMaker
  attr_reader :flash

  def initialize(current_user, invitee_handle)
    @current_user = current_user
    @invitee_handle = invitee_handle
  end

  def setup_email
    inviter_handle = @current_user.github_handle
    inviter_attr = github_service.user_attributes(inviter_handle)
    invitee_attr = github_service.user_attributes(@invitee_handle)
    return if api_errors?(invitee_attr)
    return if no_invitee_email?(invitee_attr)

    send_mailer(inviter_attr, invitee_attr)
  end

  private

  def github_service
    @github_service ||= GithubApiService.new(@current_user.github_token)
  end

  def api_errors?(invitee_attr)
    return false unless invitee_attr.key?(:message)

    @flash = { danger: "Failed to find the Github user with handle #{@invitee_handle}" }
  end

  def no_invitee_email?(invitee_attr)
    if invitee_attr[:email]
      @invitee_email = invitee_attr[:email]
      false
    else
      @flash = { danger: "The Github user you selected doesn't have an email address associated with their account." }
    end
  end

  def send_mailer(inviter_attr, invitee_attr)
    inviter_name = inviter_attr[:name]
    invitee_name = invitee_attr[:name]
    UserMailer.invite_email(inviter_name, invitee_name, @invitee_email)
              .deliver_later
    @flash = { success: 'Successfully sent invite!' }
  end
end
