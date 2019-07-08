require 'rails_helper'

RSpec.describe GithubUser, type: :model do
  before(:each) do
    @github_user_data = {login: "chakeresa", html_url: "github profile URL"}
    @github_user = GithubUser.new(@github_user_data)
  end

  it 'exists' do
    expect(@github_user).to be_a(GithubUser)
  end

  it 'has attributes' do
    expect(@github_user.handle).to eq(@github_user_data[:login])
    expect(@github_user.url).to eq(@github_user_data[:html_url])
  end
end
