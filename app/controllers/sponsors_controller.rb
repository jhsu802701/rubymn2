#
class SponsorsController < ApplicationController
  # BEGIN: action section
  def show
    @sponsor = Sponsor.find(params[:id])
  end
  # END: action section

  def index
    ord = 'updated_at desc'
    @sponsors_current = Sponsor.where('current=?', true).order(ord)
    @sponsors_past = Sponsor.where('current!=?', true).order(ord)
  end
end
