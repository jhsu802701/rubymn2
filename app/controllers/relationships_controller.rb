#
class RelationshipsController < ApplicationController
  # NOTE: Checking to see if the user is the right user is not a viable
  # way to proceed.  The authenticate_user command is used instead.
  before_action :authenticate_user!

  def create
    @user2 = User.find(params[:followed_id])
    current_user.follow(@user2)
    redirect_to(user_path(@user2))
  end

  def destroy
    @user2 = Relationship.find(params[:id]).followed
    current_user.unfollow(@user2)
    redirect_to user_path(@user2)
  end
end
