class FriendshipsController < ApplicationController
  def create
    user = User.find_by(github_handle: params["github_handle"])
    current_user.be_my_friend(user)
    redirect_to '/dashboard'
  end
end
