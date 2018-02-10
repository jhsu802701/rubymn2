#
class ForhiresController < ApplicationController
  # BEGIN: action section
  def show
    @forhire = Forhire.find(params[:id])
    @user = User.where("id=#{@forhire.user_id}").first
  end

  # rubocop:disable Metrics/AbcSize
  def index
    @search = Forhire.search(params[:q].presence)
    # NOTE: The following line specifies the sort order.
    # This is reflected in the default sort criteria shown.
    # The user is free to remove these default criteria.
    @search.sorts = 'updated_at desc' if @search.sorts.empty?
    @search.build_condition if @search.conditions.empty?
    @search.build_sort if @search.sorts.empty?
    @forhires = @search.result
    @forhires_count = @forhires.count
    @forhires = @forhires.page(params[:page]).per(50)
  end
  # rubocop:enable Metrics/AbcSize
  # END: action section
end
