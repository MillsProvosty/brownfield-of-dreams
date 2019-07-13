# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GithubUser, type: :model do
  describe 'basic functions' do
    before(:each) do
      @github_user_data = { login: 'chakeresa', html_url: 'github prof URL' }
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

  describe 'can_be_friend_of(current_user)' do
    it 'is true when user exists and not yet friends' do
      handle = 'kylecornelissen'
      github_user = GithubUser.new(login: handle, html_url: 'github prof URL')
      create(:user_with_github, github_handle: handle)
      current_user = create(:user_with_github)
      expect(github_user.can_be_friend_of?(current_user)).to eq(true)
    end

    it 'is false when user does not exist' do
      handle = 'kylecornelissen'
      github_user = GithubUser.new(login: handle, html_url: 'github prof URL')
      current_user = create(:user_with_github)
      expect(github_user.can_be_friend_of?(current_user)).to eq(false)
    end

    it 'is false when user is already a friend' do
      handle = 'kylecornelissen'
      github_user = GithubUser.new(login: handle, html_url: 'github prof URL')
      corresponding_user = create(:user_with_github, github_handle: handle)
      current_user = create(:user_with_github)
      current_user.friendships.create(friend: corresponding_user)
      expect(github_user.can_be_friend_of?(current_user)).to eq(false)
    end
  end
end
