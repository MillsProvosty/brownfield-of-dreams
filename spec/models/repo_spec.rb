# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Repo, type: :model do
  before(:each) do
    @repo_data = { name: 'little shop', url: 'little shop URL' }
    @repo = Repo.new(@repo_data)
  end

  it 'exists' do
    expect(@repo).to be_a(Repo)
  end

  it 'has attributes' do
    expect(@repo.name).to eq(@repo_data[:name])
    expect(@repo.url).to eq(@repo_data[:url])
  end
end
