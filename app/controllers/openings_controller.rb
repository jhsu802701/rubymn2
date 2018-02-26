#
class OpeningsController < ApplicationController
  # BEGIN: before_action section
  # rubocop:disable Style/SymbolArray
  before_action :may_view_opening, only: [:show, :index]
  # rubocop:enable Style/SymbolArray
  before_action :may_create_opening, only: [:create]
  before_action :may_edit_opening, only: [:update]
  before_action :may_destroy_opening, only: [:destroy]
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

  def create
    @opening = current_user.openings.build(opening_params)
    if @opening.save
      flash[:info] = 'Job opening added'
      redirect_to user_path(current_user)
    else
      render 'new'
    end
  end

  def new
    @opening = Opening.new
  end

  def update
    @opening = Opening.find(params[:id])
    if @opening.update_attributes(opening_params)
      flash[:success] = 'Job opening updated'
      redirect_to opening_path(@opening)
    else
      render 'edit'
    end
  end

  def edit
    @opening = Opening.find(params[:id])
  end

  def destroy
    uid = Opening.find(params[:id]).user_id
    Opening.find(params[:id]).destroy
    flash[:success] = 'Job opening deleted'
    redirect_to user_path(uid)
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

  def may_create_opening
    return redirect_to(root_path) unless user_signed_in?
  end
  helper_method :may_create_opening

  def may_edit_opening
    return redirect_to root_url unless user_signed_in?
    @opening = current_user.openings.find_by(id: params[:id])
    return redirect_to root_url if @opening.nil?
  end

  def correct_user
    return false unless user_signed_in?
    current_user.id == Opening.find(params[:id]).user_id
  end
  helper_method :correct_user

  def may_destroy_opening
    return redirect_to(root_path) unless correct_user || admin_signed_in?
  end
  helper_method :may_destroy_opening

  def opening_params
    params.require(:opening).permit(:title, :source_code_url,
                                    :deployed_url, :description)
  end
  # END: private section
end
