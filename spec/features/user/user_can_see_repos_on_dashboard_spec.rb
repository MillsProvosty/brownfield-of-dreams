# As a logged in user
# When I visit /dashboard
# Then I should see a section for "Github"
# And under that section I should see a list of 5 repositories with the name of each Repo linking to the repo on Github
#   API call uses: https://developer.github.com/v3/repos/#list-your-repositories

require 'rails_helper'

describe 'Logged-in user' do
  before(:each) do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  end

  describe 'dasboard page' do
    it 'user can see a list of repos' do
      VCR.use_cassette('user_repos') do
        visit '/dashboard'

        within('#github') do
          expect(page).to have_content("Github")
          expect(page.all(".repo_list").count).to eq(5)
          within(first(".repo_list")) do
            expect(page).to have_link("1903_final")
          end
        end
      end
    end
  end
end
