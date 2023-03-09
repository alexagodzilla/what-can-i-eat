class BookmarksController < ApplicationController
  def index
    @user_bookmarks = Bookmark.where(user: current_user)
  end

  def create
    @bookmark = Bookmark.new
    @bookmark.user = current_user
    @bookmark.recipe = Recipe.find(params[:recipe_id])
    redirect_to @bookmark.recipe if @bookmark.save!
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    @bookmark.destroy
    redirect_to recipe_path(@bookmark.recipe)
  end
end
