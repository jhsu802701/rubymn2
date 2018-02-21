#
class ProjectsController < ApplicationController
  # BEGIN: action section
  def show
    @project = Project.find(params[:id])
    @user = User.where("id=#{@project.user_id}").first
  end

  # rubocop:disable Metrics/AbcSize
  def index
    @search = Project.search(params[:q].presence)
    # NOTE: The following line specifies the sort order.
    # This is reflected in the default sort criteria shown.
    # The user is free to remove these default criteria.
    @search.sorts = 'updated_at desc' if @search.sorts.empty?
    @search.build_condition if @search.conditions.empty?
    @search.build_sort if @search.sorts.empty?
    @projects = @search.result
    @projects_count = @projects.count
    @projects = @projects.order('updated_at desc').page(params[:page]).per(50)
  end
  # rubocop:enable Metrics/AbcSize
  # END: action section
end
