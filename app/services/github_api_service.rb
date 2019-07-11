# frozen_string_literal: true

class GithubApiService
  def initialize(github_token)
    @github_token = github_token
  end

  def user_repos(limit)
    fetch_data("/user/repos?page=1&per_page=#{limit}")
  end

  def user_followers
    fetch_data('/user/followers')
  end

  def followed_users
    fetch_data('/user/following')
  end

  private

  def conn
    @conn ||= Faraday.new(url: 'https://api.github.com') do |f|
      f.adapter Faraday.default_adapter
    end
  end

  def fetch_data(uri_path)
    response = conn.get do |req|
      req.url uri_path
      req.params['access_token'] = @github_token
    end
    JSON.parse(response.body, symbolize_names: true)
  end
end
