# frozen_string_literal: true

class InvitesController < ApplicationController
  def new; end

  def create
    invitee_handle = params[:github_handle]
    invite_maker = InviteMaker.new(current_user, invitee_handle)
    invite_maker.setup_email
    flash[invite_maker.flash.keys.first] = invite_maker.flash.values.first
    redirect_to dashboard_path
  end
end
