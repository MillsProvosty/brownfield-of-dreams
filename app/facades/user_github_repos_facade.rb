class UserGithubReposFacade

  def user_github_repos
    fetch_data("/user/repos").map do |r|
      attributes = {
        name: r[:name],
        url: r[:url]
      }
      Repo.new(attributes)
    end.first(5)
  end

private
  def get_json(url, params)
    response = conn.get()
  end

  def conn
    Faraday.new(url: "https://api.github.com") do |f|
      f.adapter Faraday.default_adapter
      f.headers["Authorization"] = "token " + ENV['GITHUB_TOKEN']
    end
  end

  def fetch_data(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end
end
