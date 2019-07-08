# frozen_string_literal: true

class GithubAuthController < ApplicationController
  def create
    current_user.update_github_auth(auth_hash)
    redirect_to '/dashboard'
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end
end
