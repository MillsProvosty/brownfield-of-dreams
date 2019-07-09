# frozen_string_literal: true

require 'rails_helper'

describe 'Videos API' do
  it 'sends a single tutorial' do
    tutorial = create(:tutorial)
    first_video = create(:video, tutorial_id: tutorial.id)
    create(:video, tutorial_id: tutorial.id)

    get "/api/v1/videos/#{first_video.id}"

    expect(response).to be_successful

    parsed = JSON.parse(response.body, symbolize_names: true)

    expect(parsed[:id]).to eq(first_video.id)
  end
end
