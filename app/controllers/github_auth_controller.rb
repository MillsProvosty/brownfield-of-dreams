class GithubAuthController < ApplicationController
  def create
    user = current_user.update_github_login_details(auth_hash)
    redirect_to '/dashboard'
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end
end
