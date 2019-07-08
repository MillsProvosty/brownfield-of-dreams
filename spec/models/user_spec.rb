# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:password) }
  end

  describe 'relationships' do
    it { should have_many(:friendships) }
    it { should have_many(:friends).through(:friendships) }
  end

  describe 'roles' do
    it 'can be created as default user' do
      user = User.create(email: 'user@email.com', password: 'password', first_name: 'Jim', role: 0)

      expect(user.role).to eq('default')
      expect(user.default?).to be_truthy
    end

    it 'can be created as an Admin user' do
      admin = User.create(email: 'admin@email.com', password: 'admin', first_name: 'Bob', role: 1)

      expect(admin.role).to eq('admin')
      expect(admin.admin?).to be_truthy
    end
  end

  describe 'instance methods' do
    it '#update_github_auth' do
      user = create(:user)
      uid = '42'
      token = '12345'
      nickname = 'kyle'
      url = 'https://github.com/kyle'

      auth_hash = {
        'provider' => 'github',
        'uid' => uid,
        'credentials' => {
          'token' => token
        },
        'info' => {
          'nickname' => nickname,
          'urls' => {
            'GitHub' => url
          }
        }
      }

      user.update_github_auth(auth_hash)

      expect(user.github_uid).to eq(uid)
      expect(user.github_token).to eq(token)
      expect(user.github_url).to eq(url)
      expect(user.github_handle).to eq(nickname)
    end
  end

  describe '.add_friend' do
    it 'adds a friend if they are a user and not already a friend' do
      current_user = create(:user_with_github)
      github_handle = 'kyle'
      potential_friend = create(:user_with_github, github_handle: github_handle)

      expect(current_user.add_friend(github_handle)).to eq(:success)

      expect(current_user.friends.first).to eq(potential_friend)
    end

    it 'does not add friend if they are not a registered user' do
      current_user = create(:user_with_github)
      github_handle = 'kyle'

      expect(current_user.add_friend(github_handle)).to eq(:user_not_in_system)

      expect(current_user.friends.count).to eq(0)
    end

    it 'does not add a friend if they are already a friend' do
      current_user = create(:user_with_github)
      github_handle = 'kyle'
      potential_friend = create(:user_with_github, github_handle: github_handle)
      current_user.friendships.create(friend: potential_friend)

      expect(current_user.add_friend(github_handle)).to eq(:already_friends)

      expect(current_user.friends.count).to eq(1)
    end
  end
end
