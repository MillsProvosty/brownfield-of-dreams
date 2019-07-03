require 'rails_helper'

describe GithubApiService do
  it 'exists' do
    expect(subject).to be_a(GithubApiService)
  end

  it '#user_repos' do
    VCR.use_cassette("github_api_user_repos") do
      repos = subject.user_repos
      expect(repos).to be_an(Array)
      expect(repos.first).to have_key(:name)
      expect(repos.first).to have_key(:url)
      expect(repos.count).to eq(30)
    end
  end
end