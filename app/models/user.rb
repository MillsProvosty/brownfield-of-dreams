class User < ApplicationRecord
  has_many :user_videos
  has_many :videos, through: :user_videos
  # TO DO: add relationship tests
  has_many :friendships
  has_many :friended_users, through: :friendships

  validates :email, uniqueness: true, presence: true
  validates_presence_of :password, on: :create
  validates_presence_of :first_name
  enum role: [:default, :admin]
  has_secure_password

  def update_github_auth(auth_hash)
    self.github_uid = auth_hash["uid"]
    self.github_handle = auth_hash["info"]["nickname"]
    self.github_token = auth_hash["credentials"]["token"]
    self.save
  end

  def add_friend(github_handle)
    if friend = User.find_by(github_handle: github_handle)
      if friendships.find_by(friended_user: friend)
        :already_exists
      else
        friendships.create!(friended_user: friend)
        :success
      end
    else
      :not_in_system
    end
  end
end
