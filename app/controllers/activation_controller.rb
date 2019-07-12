# frozen_string_literal: true

class ActivationController < ApplicationController
  def create
    user = User.find(params[:user_id])
    user.update(active: true)
  end
end
