class UserShowFacade
  def repos
    repos_hash = GithubApiService.new.user_repos
    repos_hash.map do |repo_data|
      Repo.new(repo_data)
    end.first(5)
  end

  def followers
    follower_hash = GithubApiService.new.user_followers
    follower_hash.map do |follower_data|
      User.new
    end 
  end
end
