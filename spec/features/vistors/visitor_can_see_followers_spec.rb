require 'rails_helper'

describe "Gihub visitors" do
  it "can see followers" do
    WebMock.allow_net_connect!
    VCR.turn_off!
    visitor = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(visitor)

    visit '/dashboard'

    within("#github") do
      expect(page).to have_content("Followers")
      expect(page.all(".follower_list").count).to eq(5)
      within(first(".follower_list")) do
        expect(page).to have_link("kylecornelissen")
      end
    end
  end
end
