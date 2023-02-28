class BookmarksController < ApplicationController
  def create
    @bookmark = Bookmark.new
    @bookmark.user = current_user
    @bookmark.recipe = Recipe.find(params[:recipe_id])
    if @bookmark.save!
      redirect_to @bookmark.recipe
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    @bookmark.destroy
    redirect_back fallback_location: root_path
  end
end
