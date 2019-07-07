class FriendshipsController < ApplicationController
  def create
    github_handle = params[:github_handle]
    case current_user.add_friend(github_handle)
    when :success
      flash[:success] = "#{github_handle} added as a friend"
    when :already_exists
      flash[:danger] = "#{github_handle} is already a friend"
    when :not_in_system
      flash[:danger] = "#{github_handle} is not a user of this site"
    end
    redirect_to :dashboard
  end
end
