class RecipesController < ApplicationController
  def index
    @recipes = Recipe.all
  end

  def show
    @bookmark = Bookmark.new
    @review = Review.new
    @recipe = Recipe.find(params[:id])
    @current_user_bookmarks = Bookmark.where(user: current_user)
  end
end
