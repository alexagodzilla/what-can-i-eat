class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
  end

  def profile
    @current_user_bookmarks = Bookmark.where(user: current_user)
  end
end
