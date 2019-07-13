# frozen_string_literal: true

class WelcomeController < ApplicationController
  def index
    @tutorials = if params[:tag]
                   filter_tutorials.tagged_with(params[:tag])
                   .paginate(page: params[:page], per_page: 5)
                 else
                   filter_tutorials.paginate(page: params[:page], per_page: 5)
                 end
  end

  def filter_tutorials
    if current_user
      Tutorial.all
    else
      Tutorial.public_tutorials
    end
  end
end
