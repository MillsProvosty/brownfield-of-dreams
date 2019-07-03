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

  it '#user_followers' do
    VCR.use_cassette("github_api_user_followers") do
      followers = subject.user_followers
      expect(followers).to be_an(Array)
      expect(followers.first).to have_key(:login)
      expect(followers.first).to have_key(:url)
      expect(followers.count).to eq(5)
    end
  end

  it '#followed_users' do
    VCR.use_cassette("github_api_followed_users") do
      users_followed = subject.followed_users
      expect(users_followed).to be_an(Array)
      expect(users_followed.first).to have_key(:login)
      expect(users_followed.first).to have_key(:url)
      expect(users_followed.count).to eq(5)
    end
  end
end
