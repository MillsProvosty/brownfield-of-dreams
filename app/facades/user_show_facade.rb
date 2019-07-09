# frozen_string_literal: true

class UserShowFacade
  def initialize(user)
    @user = user
  end

  def repos
    repos_hash = github_service.user_repos(5)
    repos_hash.map do |repo_data|
      Repo.new(repo_data)
    end
  end

  def followers
    followers_hash = github_service.user_followers
    followers_hash.map do |follower_data|
      GithubUser.new(follower_data)
    end
  end

  def followed_users
    followed_users_hash = github_service.followed_users
    followed_users_hash.map do |followed_user_data|
      GithubUser.new(followed_user_data)
    end
  end

  def friends
    @user.reload.friends
  end

  private

  def github_service
    GithubApiService.new(@user.github_token)
  end

  def bookmarked_tutorials
    Tutorial.bookmarked_tutorials_for_user(@user_id)
  end
end
