require "rails_helper"

RSpec.describe ActivationMailer, type: :mailer do
  describe "activation email after registration" do
    before :each do
      let(:mail) { ActivationMailer.register }
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
end
