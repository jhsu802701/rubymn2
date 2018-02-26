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

  # rubocop:disable Metrics/AbcSize
  def index
    @search = Opening.search(params[:q].presence)
    # NOTE: The following line specifies the sort order.
    # This is reflected in the default sort criteria shown.
    # The user is free to remove these default criteria.
    @search.sorts = 'updated_at desc' if @search.sorts.empty?
    @search.build_condition if @search.conditions.empty?
    @search.build_sort if @search.sorts.empty?
    @openings = @search.result
    @openings_count = @openings.count
    @openings = @openings.order('updated_at desc').page(params[:page]).per(50)
  end
  # rubocop:enable Metrics/AbcSize
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
