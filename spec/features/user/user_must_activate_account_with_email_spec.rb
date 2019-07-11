require 'rails_helper'

RSpec.describe "Notifications" do
  include ActionMailer::TestHelper
  describe "As a non-activated user" do
    before :each do
      email = 'jimbob@aol.com'
      first_name = 'Jim'
      last_name = 'Bob'
      password = 'password'
      password_confirmation = 'password'

      visit new_user_path

      fill_in 'user[email]', with: email
      fill_in 'user[first_name]', with: first_name
      fill_in 'user[last_name]', with: last_name
      fill_in 'user[password]', with: password
      fill_in 'user[password_confirmation]', with: password
    end
    # 
    # it "I receive an email" do
    #   assert_emails 1 do
    #     click_on 'Create Account'
    #   end
    # end

    describe "when I click the link" do
      before :each do
        click_on 'Create Account'
        visit activate_user_path(User.last.id)
      end

      it "I should be taken to an activation page" do
        expect(page).to have_content("Thank you! Your account is now activated.")
      end

      it "when I visit dashboard, I should see status active" do
        visit dashboard_path
        expect(page).to have_content("Status: Active")
      end
    end
  end
end
