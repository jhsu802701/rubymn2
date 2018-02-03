#
class SponsorsController < ApplicationController
  # BEGIN: action section
  def show
    @sponsor = Sponsor.find(params[:id])
  end
  # END: action section
end
