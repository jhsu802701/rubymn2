#
class ForhiresController < ApplicationController
  # BEGIN: before_action section
  before_action :may_create_forhire, only: [:create]
  # END: before_action section

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

  def create
    @forhire = current_user.forhires.build(forhire_params)
    if @forhire.save
      flash[:info] = 'For hire profile added'
      redirect_to user_path(current_user)
    else
      render 'new'
    end
  end

  def new
    @forhire = Forhire.new
  end
  # END: action section

  # BEGIN: private section
  # rubocop:disable Metrics/LineLength
  def may_create_forhire
    return redirect_to(root_path) unless user_signed_in?
    return redirect_to(root_path) unless Forhire.where("user_id=#{current_user.id}").empty?
  end
  helper_method :may_create_forhire
  # rubocop:enable Metrics/LineLength

  def forhire_params
    params.require(:forhire).permit(:title, :email, :description)
  end
  # END: private section
end
