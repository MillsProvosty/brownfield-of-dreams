class User < ApplicationRecord
  has_many :user_videos
  has_many :videos, through: :user_videos

  validates :email, uniqueness: true, presence: true
  validates_presence_of :password_digest
  validates_presence_of :first_name
  enum role: [:default, :admin]
  has_secure_password

  def update_github_login_details(auth_hash)
    github_login_details = {
      github_uid:      auth_hash["uid"],
      github_username: auth_hash["info"]["nickname"],
      github_token:    auth_hash["credentials"]["token"]
    }
    update(github_login_details)
    self.reload
  end
end
