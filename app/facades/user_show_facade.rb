class UserShowFacade
  def repos
    repos_hash = GithubApiService.new.user_repos
    repos_hash.map do |repo_data|
      Repo.new(repo_data)
    end.first(5)
  end

  def followers
    followers_hash = GithubApiService.new.user_followers
    followers_hash.map do |follower_data|
      GithubUser.new(follower_data)
    end
  end
end
