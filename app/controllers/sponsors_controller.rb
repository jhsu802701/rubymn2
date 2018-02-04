#
class SponsorsController < ApplicationController
  before_action :may_control_sponsor, only: [:create]

  # BEGIN: action section
  def show
    @sponsor = Sponsor.find(params[:id])
  end

  def index
    ord = 'updated_at desc'
    @sponsors_current = Sponsor.where('current=?', true).order(ord)
    @sponsors_past = Sponsor.where('current!=?', true).order(ord)
  end

  def create
    @sponsor = Sponsor.new(sponsor_params)
    if @sponsor.save
      flash[:info] = 'Sponsor added'
      redirect_to sponsors_path
    else
      render 'new'
    end
  end

  def new
    @sponsor = Sponsor.new
  end
  # END: action section

  private

  # BEGIN: private section
  def may_control_sponsor
    return redirect_to(root_path) if no_control == true
  end
  helper_method :may_control_sponsor

  def no_control
    ca = current_admin
    # No control over sponsor given any of the following conditions:
    # 1.  current_admin is nil OR
    # 2.  Not a super admin OR
    ca.nil? || ca.super != true
  end
  helper_method :no_control

  def sponsor_params
    params.require(:sponsor).permit(:name, :phone, :description,
                                    :contact_email, :contact_url, :current)
  end
  # END: private section
end
