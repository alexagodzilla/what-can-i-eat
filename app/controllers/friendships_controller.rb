class FriendshipsController < ApplicationController
  def create
    @friendship = Friendship.new
    @friendship.requester = current_user
    @friendship.requested = User.find(params[:friendship][:requested])
    @friendship.status = "pending"
    return unless @friendship.save!

    redirect_back_or_to profile_friends_path, notice: "Invite sent to #{@friendship.requested.username}"
  end
end
