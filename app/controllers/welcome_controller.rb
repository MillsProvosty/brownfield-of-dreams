# frozen_string_literal: true

class WelcomeController < ApplicationController
  def index
    if params[:tag]
      @tutorials = Tutorial.viewable.tagged_with(params[:tag]).paginate(page: params[:page], per_page: 5)
    else
      @tutorials = Tutorial.viewable.paginate(page: params[:page], per_page: 5)
    end
  end
end
