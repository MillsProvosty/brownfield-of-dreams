# frozen_string_literal: true

require 'rails_helper'

describe GithubApiService do
  before(:each) do
    user = create(:user_with_github)
    @service = GithubApiService.new(user.id)
  end

  it 'exists' do
    expect(@service).to be_a(GithubApiService)
  end

  it '#user_repos' do
    VCR.use_cassette('github_api_user_repos', record: :new_episodes) do
      repos = @service.user_repos
      expect(repos).to be_an(Array)
      expect(repos.first).to have_key(:name)
      expect(repos.first).to have_key(:url)
      expect(repos.count).to eq(30)
    end
  end

  it '#user_followers' do
    VCR.use_cassette('github_api_user_followers', record: :new_episodes) do
      followers = @service.user_followers
      expect(followers).to be_an(Array)
      expect(followers.first).to have_key(:login)
      expect(followers.first).to have_key(:url)
      expect(followers.count).to eq(7)
    end
  end

  it '#followed_users' do
    VCR.use_cassette('github_api_followed_users', record: :new_episodes) do
      users_followed = @service.followed_users
      expect(users_followed).to be_an(Array)
      expect(users_followed.first).to have_key(:login)
      expect(users_followed.first).to have_key(:url)
      expect(users_followed.count).to eq(6)
    end
  end
end
