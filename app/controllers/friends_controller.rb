class FriendsController < ApplicationController
  before_action :authenticate_user!
  def index
    @friends = current_user.friends
  end
  def add
    friend = User.find(params[:id])
    if  current_user.add_friend(friend)
      redirect_to  :back,notice: "Added friend."
    else
      redirect_to  :back,alert:"Unable to add friend."
    end
  end

  def destroy
    @friendship = FriendShip.find_by(user_id:current_user.id,friend_id:params[:id])
    if @friendship.destroy
      redirect_to :back
    end
  end
end
