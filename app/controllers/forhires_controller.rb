#
class ForhiresController < ApplicationController
  # BEGIN: before_action section
  before_action :may_create_forhire, only: [:create]
  before_action :may_edit_forhire, only: [:update]
  before_action :may_destroy_forhire, only: [:destroy]
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
    @forhires = @forhires.order('updated_at desc').page(params[:page]).per(50)
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

  def update
    @forhire = Forhire.find(params[:id])
    if @forhire.update_attributes(forhire_params)
      flash[:success] = 'Forhire updated'
      redirect_to forhire_path(@forhire)
    else
      render 'edit'
    end
  end

  def edit
    @forhire = Forhire.find(params[:id])
  end

  def destroy
    uid = Forhire.find(params[:id]).user_id
    Forhire.find(params[:id]).destroy
    flash[:success] = 'For hire profile deleted'
    redirect_to user_path(uid)
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

  def may_edit_forhire
    return redirect_to root_url unless user_signed_in?
    @forhire = current_user.forhires.find_by(id: params[:id])
    return redirect_to root_url if @forhire.nil?
  end

  def correct_user
    return false unless user_signed_in?
    current_user.id == Forhire.find(params[:id]).user_id
  end
  helper_method :correct_user

  def may_destroy_forhire
    return redirect_to(root_path) unless correct_user || admin_signed_in?
  end
  helper_method :may_destroy_forhire

  def forhire_params
    params.require(:forhire).permit(:title, :email, :description)
  end
  # END: private section
end
