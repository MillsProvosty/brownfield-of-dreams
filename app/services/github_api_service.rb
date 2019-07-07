class GithubApiService
  def initialize(user_id)
    @user_id = user_id
  end

  def user_repos
    fetch_data('/user/repos')
  end

  def user_followers
    fetch_data('/user/followers')
  end

  def followed_users
    fetch_data('/user/following')
  end

  private

  def conn
    Faraday.new(url:"https://api.github.com") do |f|
      f.adapter  Faraday.default_adapter
    end
  end

  def fetch_data(uri_path)
    response = conn.get do |req|
      req.url uri_path
      req.params["access_token"] = User.find(@user_id).github_token
    end
    JSON.parse(response.body, symbolize_names: true)
  end
end
