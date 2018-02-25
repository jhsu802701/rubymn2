#
class OpeningsController < ApplicationController
  # BEGIN: before_action section
  before_action :may_view_project, only: [:show]
  # END: before_action section

  # BEGIN: action section
  def show
    @opening = Opening.find(params[:id])
    @user = User.where("id=#{@opening.user_id}").first
  end
  # END: action section

  private

  # BEGIN: private section
  def may_view_project
    return if user_signed_in? || admin_signed_in?
    flash[:alert] = 'You must be logged in to view job openings.'
    redirect_to(new_user_session_path)
  end
  helper_method :may_view_project
  # END: private section
end
