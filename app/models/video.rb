# frozen_string_literal: true

class Video < ApplicationRecord
  has_many :user_videos
  has_many :users, through: :user_videos
  belongs_to :tutorial

  validates_presence_of :position

  def self.bookmarked_videos_for_user(user_id)
    joins(:user_videos)
      .includes(:tutorial)
      .where(user_videos: {user_id: user_id})
      .order(:tutorial_id, :position)
  end
end
