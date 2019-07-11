require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  describe "activation email after registration" do
    before :each do
      @user = create(:user)
      @mail = UserMailer.activation_email(@user)
    end

    it "renders the headers" do
      expect(@mail.subject).to eq("Activate Your Account")
      expect(@mail.to).to eq([@user.email])
      expect(@mail.from).to eq(["no_reply@brownfieldofdreams.com"])
    end

    it "renders the body" do
      expect(@mail.body.encoded).to match("Visit here to activate your account.")
    end
  end

  describe "invite email to a github user" do
    before :each do
      inviter_attr = { full_name: 'Alexandra Chakeres' }
      invitee_attr = { full_name: 'Kyle Cornelissen', email: 'kyle@gmail.com' }
      @inviter = GitHubUser.new(inviter_attr)
      @invitee = GitHubUser.new(invitee_attr)
      @mail = UserMailer.invite_email(@inviter, @invitee)
    end

    it "renders the headers" do
      expect(@mail.subject).to eq("Join Brownfield of Dreams!")
      expect(@mail.to).to eq([@invitee.email])
      expect(@mail.from).to eq(["no_reply@brownfieldofdreams.com"])
    end

    it "renders the body" do
      expect(@mail.body.encoded).to match("Hello #{@invitee.full_name},\n#{@inviter.full_name} has invited you to join Brownfield of Dreams. You can create an account here.")
    end
  end
end
