class GithubApiService
  def user_repos
    fetch_data('/user/repos')
  end

  private

  def conn
    Faraday.new(url: "https://api.github.com") do |faraday|
      faraday.headers['Authorization'] = "token #{ENV["GITHUB_API_KEY"]}"
      faraday.adapter  Faraday.default_adapter
    end
  end

  def fetch_data(uri_path)
    response = conn.get uri_path
    JSON.parse(response.body, symbolize_names: true)
  end
end
