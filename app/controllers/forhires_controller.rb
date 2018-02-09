#
class ForhiresController < ApplicationController
  # BEGIN: action section
  def show
    @forhire = Forhire.find(params[:id])
    @user = User.where("id=#{@forhire.user_id}").first
  end

  def index
    @forhires = Forhire.order('updated_at DESC').page(params[:page]).per(50)
    @forhires_count = Forhire.count
  end
  # END: action section
end
