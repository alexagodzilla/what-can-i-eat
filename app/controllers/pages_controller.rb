class PagesController < ApplicationController
  # skip_before_action :authenticate_user!, only: [ :home ]

  def profile
    @chatroom = Chatroom.first
    @user_bookmarks = Bookmark.where(user: current_user)
    @user_ingredients = UserIngredient.where(user: current_user)
    @user_ingredient = UserIngredient.new
  end

  def friends
    @pending_friends = current_user.pending_friends
    @friendships = friendships_finder(@pending_friends)
  end

  def friendships_finder(pending_friends)
    pending_friends.map do |person|
      Friendship.where(requested: current_user, requester: person)
    end
  end
end
