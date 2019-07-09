# frozen_string_literal: true

class UserShowFacade
  def initialize(user_id)
    @user_id = user_id
  end

  def repos
    repos_hash = GithubApiService.new(@user_id).user_repos
    repos_hash.map do |repo_data|
      Repo.new(repo_data)
    end.first(5)
  end

  def followers
    followers_hash = GithubApiService.new(@user_id).user_followers
    followers_hash.map do |follower_data|
      GithubUser.new(follower_data)
    end
  end

  def followed_users
    followed_users_hash = GithubApiService.new(@user_id).followed_users
    followed_users_hash.map do |followed_user_data|
      GithubUser.new(followed_user_data)
    end
  end

  def friends
    current_user = User.find(@user_id)
    current_user.friends
  end

  def bookmarked_tutorials
    Tutorial.bookmarked_tutorials_for_user(@user_id)
  end
end
