#
class ProjectsController < ApplicationController
  # BEGIN: action section
  def show
    @project = Project.find(params[:id])
    @user = User.where("id=#{@project.user_id}").first
  end

  def index
    @projects = Project.order('updated_at DESC').page(params[:page]).per(50)
    @projects_count = Project.count
  end
  # END: action section
end
