require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it {should validate_presence_of(:email)}
    it {should validate_presence_of(:first_name)}
    it {should validate_presence_of(:password)}
  end

  describe 'roles' do
    it 'can be created as default user' do
      user = User.create(email: 'user@email.com', password: 'password', first_name:'Jim', role: 0)

      expect(user.role).to eq('default')
      expect(user.default?).to be_truthy
    end

    it 'can be created as an Admin user' do
      admin = User.create(email: 'admin@email.com', password: 'admin', first_name:'Bob', role: 1)

      expect(admin.role).to eq('admin')
      expect(admin.admin?).to be_truthy
    end
  end

  describe 'instance methods' do
    it "#update_github_auth" do
      user = create(:user)
      uid = "42"
      nickname = "github_acct_name"
      token = "12345"
      auth_hash = {
        "provider" => 'github',
        "uid" => uid,
        "info" => {
          "nickname" => nickname
        },
        "credentials" => {
          "token" => token
        }
      }

      user.update_github_auth(auth_hash)

      expect(user.github_uid).to eq(uid)
      expect(user.github_handle).to eq(nickname)
      expect(user.github_token).to eq(token)
    end

    xit "#add_friend" do
      # TO DO 
    end
  end
end
