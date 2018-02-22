#
class ProjectsController < ApplicationController
  # BEGIN: before_action section
  before_action :may_create_project, only: [:create]
  # END: before_action section

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

  def create
    @project = current_user.projects.build(project_params)
    if @project.save
      flash[:info] = 'Project added'
      redirect_to user_path(current_user)
    else
      render 'new'
    end
  end

  def new
    @project = Project.new
  end
  # END: action section

  private

  # BEGIN: private section
  def may_create_project
    return redirect_to(root_path) unless user_signed_in?
  end
  helper_method :may_create_project

  def project_params
    params.require(:project).permit(:title, :source_code_url,
                                    :deployed_url, :description)
  end
  # END: private section
end
