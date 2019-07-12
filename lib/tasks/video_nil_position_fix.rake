# frozen_string_literal: true

desc 'Override nil video positions'
task video_nil_position_fix: :environment do
  Video.where(position: nil).each do |video|
    max_position = video.tutorial.videos.maximum(:position)
    video.update(position: max_position + 1)
  end
end
