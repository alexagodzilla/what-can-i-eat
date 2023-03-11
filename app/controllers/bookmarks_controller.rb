class BookmarksController < ApplicationController
  def index
    @user_bookmarks = Bookmark.where(user: current_user)
  end

  def create
    @bookmark = Bookmark.new
    @bookmark.user = current_user
    @bookmark.recipe = Recipe.find(params[:recipe_id])
    if @bookmark.save!
      redirect_to @bookmark.recipe, notice: "Recipe saved to bookmarks"
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    @bookmark.destroy
    redirect_to profile_bookmarks_path, notice: "Recipe removed from bookmarks"
  end
end
