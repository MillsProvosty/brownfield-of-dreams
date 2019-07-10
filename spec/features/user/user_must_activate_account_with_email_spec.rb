require 'rails_helper'
require "rails_helper"

RSpec.describe Notifications, :type => :mailer do
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

    it "I receive an email" do
      assert_emails 1 do
        click_on 'Create Account'
      end
    end

    describe "When I check my email for the registration email" do
      before :each do
        click_on 'Create Account'
        let(:mail) { Notifications.register }
      end

      it "renders the headers" do
        expect(mail.subject).to eq("Signup")
        expect(mail.to).to eq([email])
        expect(mail.from).to eq(["fromTBD@example.com"])
      end

      it "renders the body" do
        expect(mail.body.encoded).to match("Visit here to activate your account.")
      end
    end

    describe "when I click the link" do
      before :each do
        click_on 'Create Account'
        visit activation_path
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
