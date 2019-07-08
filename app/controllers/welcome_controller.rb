# frozen_string_literal: true

class WelcomeController < ApplicationController

  def user_paginator
    if params[:tag]
      @tutorials = Tutorial.tagged_with(params[:tag]).paginate(page: params[:page], per_page: 5)
    else
      @tutorials = Tutorial.paginate(page: params[:page], per_page: 5)
    end
  end

  def public_paginator
    if params[:tag]
      @tutorials = Tutorial.public_videos.tagged_with(params[:tag]).paginate(page: params[:page], per_page: 5)
    else
      @tutorials = Tutorial.public_videos.paginate(page: params[:page], per_page: 5)
    end
  end

  def index
    if current_user
      user_paginator
    elsif !current_user
      public_paginator
    end
  end
end
