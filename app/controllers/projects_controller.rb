#
class ProjectsController < ApplicationController
  # BEGIN: before_action section
  before_action :may_create_project, only: [:create]
  before_action :may_edit_project, only: [:update]
  before_action :may_destroy_project, only: [:destroy]
  # END: before_action section

  # BEGIN: action section
  def show
    @project = Project.find(params[:id])
    @user = User.where("id=#{@project.user_id}").first
  end

  # rubocop:disable Metrics/AbcSize
  def index
    @search = Project.ransack(params[:q].presence)
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

  def update
    @project = Project.find(params[:id])
    if @project.update_attributes(project_params)
      flash[:success] = 'Project updated'
      redirect_to project_path(@project)
    else
      render 'edit'
    end
  end

  def edit
    @project = Project.find(params[:id])
  end

  def destroy
    uid = Project.find(params[:id]).user_id
    Project.find(params[:id]).destroy
    flash[:success] = 'Project deleted'
    redirect_to user_path(uid)
  end
  # END: action section

  private

  # BEGIN: private section
  def may_create_project
    return redirect_to(root_path) unless user_signed_in?
  end
  helper_method :may_create_project

  def may_edit_project
    return redirect_to root_url unless user_signed_in?

    @project = current_user.projects.find_by(id: params[:id])
    return redirect_to root_url if @project.nil?
  end

  def correct_user
    return false unless user_signed_in?

    current_user.id == Project.find(params[:id]).user_id
  end
  helper_method :correct_user

  def may_destroy_project
    return redirect_to(root_path) unless correct_user || admin_signed_in?
  end
  helper_method :may_destroy_project

  def project_params
    params.require(:project).permit(:title, :source_code_url,
                                    :deployed_url, :description)
  end
  # END: private section
end
