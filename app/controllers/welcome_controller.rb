# frozen_string_literal: true

class WelcomeController < ApplicationController
  def index
    if params[:tag]
        @tutorials = filter_tutorials.tagged_with(params[:tag]).paginate(page: params[:page], per_page: 5)
    else
        @tutorials = filter_tutorials.paginate(page: params[:page], per_page: 5)
    end
  end

  def filter_tutorials
    if current_user
      Tutorials.all
    else !current_user
      Tutorials.private_tutorials
    end
  end
end
