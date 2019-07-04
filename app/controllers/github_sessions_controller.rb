class GithubSessionsController < ApplicationController
  def create
    user = User.update_github_login_details(auth_hash)
    session[:github_uid] = user.github_uid
    redirect_to '/dashboard'
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end
end
