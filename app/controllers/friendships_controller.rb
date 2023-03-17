class FriendshipsController < ApplicationController
  def create
    @friendship = Friendship.new
    @friendship.requester = current_user
    @friendship.requested = User.find(params[:friendship][:requested])
    @friendship.status = "pending"
    return unless @friendship.save!

    redirect_back_or_to profile_friends_path, notice: "Invite sent to #{@friendship.requested.username}"
  end

  def update
    @pending = Friendship.find(params[:id])
    case params["friendship"]["answer"]
    when "Accept"
      @pending.update(status: "accepted")
      @pending.save!
      redirect_to profile_friends_path, notice: "You are now friends with #{@pending.requester.first_name}!"
    when "Reject"
      @pending.update(status: "rejected")
      @pending.save!
      redirect_to profile_friends_path, notice: "You have rejected #{@pending.requester.first_name}"
    end
  end
end
