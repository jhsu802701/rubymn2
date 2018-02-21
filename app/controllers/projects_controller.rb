#
class ProjectsController < ApplicationController
  # BEGIN: action section
  def show
    @project = Project.find(params[:id])
    @user = User.where("id=#{@project.user_id}").first
  end
  # END: action section
end
