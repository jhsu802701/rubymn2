#
class ForhiresController < ApplicationController
  # BEGIN: action section
  def show
    @forhire = Forhire.find(params[:id])
    @user = User.where("id=#{@forhire.user_id}").first
  end
  # END: action section
end
