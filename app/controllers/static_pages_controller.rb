#
class StaticPagesController < ApplicationController
  def home
    ord = 'updated_at desc'
    @sponsors_current = Sponsor.where('current=?', true).order(ord)
  end
end
