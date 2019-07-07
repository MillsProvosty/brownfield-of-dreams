class User < ApplicationRecord
  has_many :user_videos
  has_many :videos, through: :user_videos
  has_many :friendships
  has_many :friends, through: :friendships

  validates :email, uniqueness: true, presence: true
  validates_presence_of :password, on: :create
  validates_presence_of :first_name
  enum role: [:default, :admin]
  has_secure_password

  def update_github_auth(auth_hash)
    self.github_uid = auth_hash["uid"]
    self.github_token = auth_hash["credentials"]["token"]
    self.github_handle = auth_hash["info"]["nickname"]
    self.github_url = auth_hash["info"]["urls"]["GitHub"]
    self.save
  end

  def be_my_friend(new_friend)
    friendships.create(friend: new_friend)
  end
end
