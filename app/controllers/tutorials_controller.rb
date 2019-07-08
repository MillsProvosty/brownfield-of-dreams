# frozen_string_literal: true

class TutorialsController < ApplicationController
  before_action :require_user

  def show
    tutorial = Tutorial.find(params[:id])
    @facade = TutorialFacade.new(tutorial, params[:video_id])
  end

  private
  def require_user
    render file: "/public/404" unless current_user
  end
end
