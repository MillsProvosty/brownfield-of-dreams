# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Tutorial, type: :model do
  describe 'class methods' do
    it '.bookmarked_tutorials_for_user' do
      user = create(:user)
      other_user = create(:user)

      tutorial1 = create(:tutorial)
      tutorial2 = create(:tutorial)
      tutorial3 = create(:tutorial)
      tutorial4 = create(:tutorial)

      video11 = create(:video, tutorial_id: tutorial1.id)
      video21 = create(:video, tutorial_id: tutorial2.id)
      video31 = create(:video, tutorial_id: tutorial3.id, position: 1)
      video32 = create(:video, tutorial_id: tutorial3.id, position: 3)
      video33 = create(:video, tutorial_id: tutorial3.id, position: 2)

      user_video11 = create(:user_video, user: user, video: video11)
      user_video21 = create(:user_video, user: user, video: video21)
      user_video32 = create(:user_video, user: user, video: video32)
      user_video33 = create(:user_video, user: user, video: video33)
      other_user_video31 = create(:user_video, user: other_user, video: video31)

      result = Tutorial.bookmarked_tutorials_for_user(user.id)
      expect(result).to eq([tutorial1, tutorial2, tutorial3])
      expect(result.first.videos).to eq([video11])
      expect(result.second.videos).to eq([video21])
      expect(result.third.videos).to eq([video33, video32])
    end
  end
end
