# frozen_string_literal: true

class GithubUser
  attr_reader :handle,
              :url

  def initialize(attributes)
    @handle = attributes[:login]
    @url = attributes[:html_url]
  end

  def can_be_friend_of?(current_user)
    user_exists? && !already_friends?(current_user)
  end

  private

  def user_exists?
    friend = User.find_by(github_handle: @handle)
    friend != nil
  end

  def already_friends?(current_user)
    friend = User.find_by(github_handle: @handle)
    friendship = Friendship
    .find_by(user_id: current_user.id, friend_id: friend.id)
    friendship != nil
  end
end
