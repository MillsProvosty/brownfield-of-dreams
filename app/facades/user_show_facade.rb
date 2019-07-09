# frozen_string_literal: true

class UserShowFacade
  def initialize(user)
    @user = user
  end

  def repos
    # TO DO: abstract out GithubApiService.new into private method
    repos_hash = GithubApiService.new(@user.github_token).user_repos
    repos_hash.map do |repo_data|
      Repo.new(repo_data)
    end.first(5)
    # TO DO: ^ get rid of first(5) by using optional args on user_repos method
  end

  def followers
    followers_hash = GithubApiService.new(@user.github_token).user_followers
    followers_hash.map do |follower_data|
      GithubUser.new(follower_data)
    end
  end

  def followed_users
    followed_users_hash = GithubApiService.new(@user.github_token).followed_users
    followed_users_hash.map do |followed_user_data|
      GithubUser.new(followed_user_data)
    end
  end

  def friends
    @user.reload.friends
  end
end
