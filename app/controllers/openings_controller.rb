#
class OpeningsController < ApplicationController
  # BEGIN: before_action section
  # rubocop:disable Style/SymbolArray
  before_action :may_view_opening, only: [:show, :index]
  # rubocop:enable Style/SymbolArray
  # END: before_action section

  # BEGIN: action section
  def show
    @opening = Opening.find(params[:id])
    @user = User.where("id=#{@opening.user_id}").first
  end

  def index
    @openings = Opening.order('updated_at DESC').page(params[:page]).per(50)
    @openings_count = Opening.count
  end
  # END: action section

  private

  # BEGIN: private section
  def may_view_opening
    return if user_signed_in? || admin_signed_in?
    flash[:alert] = 'You must be logged in to view job openings.'
    redirect_to(new_user_session_path)
  end
  helper_method :may_view_opening
  # END: private section
end
