class GithubUser
  attr_reader :handle,
              :url
  def initialize(attributes)
    @handle = attributes[:login]
    @url = attributes[:html_url]
  end

  def can_be_friend_of?(current_user)
    friend = User.find_by(github_handle: @handle)
    user_exists = friend != nil
    friendship = Friendship.find_by(user_id: current_user.id, friend_id: friend.id)
    already_friends = friendship != nil
    user_exists && !already_friends
  end
end
