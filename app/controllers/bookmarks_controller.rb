class BookmarksController < ApplicationController
  def index
    @user_bookmarks = Bookmark.where(user: current_user)
  end

  def create
    @bookmark = Bookmark.new
    @bookmark.user = current_user
    @bookmark.recipe = Recipe.find(params[:recipe_id])
    redirect_to @bookmark.recipe, notice: "#{@bookmark.recipe.title} saved to bookmarks"if @bookmark.save!
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    @bookmark.destroy
    redirect_back_or_to profile_bookmarks_path, notice: "#{@bookmark.recipe.title} removed from bookmarks"
  end
end
