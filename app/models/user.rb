class User < ApplicationRecord
  has_many :user_videos
  has_many :videos, through: :user_videos

  validates :email, uniqueness: true, presence: true
  validates_presence_of :password
  validates_presence_of :first_name
  enum role: [:default, :admin]
  has_secure_password

  def update_github_login_details(auth_hash)
    github_login_details = {
      require 'pry'; binding.pry
      github_uid:      auth_hash["something"],
      github_username: auth_hash["something else"],
      github_token:    auth_hash["blah"]
    }
    update(github_login_details)
  end
end
