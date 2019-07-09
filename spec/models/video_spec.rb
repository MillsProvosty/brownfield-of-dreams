# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Video, type: :model do
  describe 'relationships' do
    it { should have_many(:user_videos) }
    it { should have_many(:users).through(:user_videos) }
    it { should belong_to(:tutorial) }
  end

  describe 'validations' do
    it { should validate_presence_of(:position) }
  end

  describe "class methods" do
    it ".bookmarked_videos_for_user" do
      user = create(:user)
      other_user = create(:user)


      tutorial1 = create(:tutorial)
      tutorial2 = create(:tutorial)
      tutorial3 = create(:tutorial)

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

      result = Video.bookmarked_videos_for_user(user.id)
      expect(result).to eq([video11, video21, video33, video32])
      expect(result.first.tutorial).to eq(tutorial1)
    end
  end
end
