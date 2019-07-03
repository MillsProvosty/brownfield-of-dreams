require 'rails_helper'

feature "User can see list of repos" do
  it "from github" do
    VCR.use_cassette("user_repo") do
      # members_json = File.read("/github.com/MillsProvosty?tab=repositories")
      # stub_request(:get, "MillsProvosty")
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit '/dashboard'

      expect(page).to have_content("Github Repos")
      expect(page).to have_content("brownfield-of-dreams")
      expect(page.all(".user_repo_list").count).to eq(5)
    end
  end
end
