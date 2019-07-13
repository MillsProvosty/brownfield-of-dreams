# frozen_string_literal: true

class User < ApplicationRecord
  has_many :user_videos
  has_many :videos, through: :user_videos
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships

  validates :email, uniqueness: true, presence: true
  validates_presence_of :password, on: :create
  validates_presence_of :first_name
  enum role: %i[default admin]
  has_secure_password

  def update_github_auth(auth_hash)
    self.github_uid = auth_hash['uid']
    self.github_token = auth_hash['credentials']['token']
    self.github_url = auth_hash['info']['urls']['GitHub']
    self.github_handle = auth_hash['info']['nickname']
    save
  end

  def add_friend(github_handle)
    potential_friend = user_with_github_handle(github_handle)
    return :user_not_in_system unless potential_friend

    if already_friends?(potential_friend)
      :already_friends
    else
      friendships.create(friend: potential_friend)
      :success
    end
  end

  def active_or_inactive
    if active
      'Active'
    else
      'Inactive'
    end
  end

  private

  def user_with_github_handle(github_handle)
    User.find_by(github_handle: github_handle)
  end

  def already_friends?(potential_friend)
    friendship = friendships.find_by(friend: potential_friend)
    friendship != nil
  end
end
