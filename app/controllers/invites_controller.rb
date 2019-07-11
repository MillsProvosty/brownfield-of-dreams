class InvitesController < ApplicationController
  def new; end

  def create
    flash[:success] = 'Successfully sent invite!'
    redirect_to dashboard_path
  end
end
