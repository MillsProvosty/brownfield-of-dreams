require 'rails_helper'

RSpec.describe "Friend", type: :model do
  before(:each) do
    @github_user_data = {login: "chakeresa", url: "github profile URL"}
    @github_user = GithubUser.new(@github_user_data)
  end
  
    it "#could_be_a_friend?" do
      user = create(:user)

      expect(user.could_be_a_friend?).to eq(false)
      expect(@github_user.could_be_a_friend?).to eq(true)
    end
end
