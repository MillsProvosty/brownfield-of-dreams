require 'rails_helper'

RSpec.describe Repo, type: :model do
  it 'exists' do
    repo_data = {name: "little shop", url: "little shop URL"}
    expect(Repo.new(repo_data)).to be_a(Repo)
  end
end
