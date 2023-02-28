class RecipesController < ApplicationController
  def index
    @recipes = Recipe.all
  end

  def show
    @bookmark = Bookmark.new
    @review = Review.new
    @recipe = Recipe.find(params[:id])
    @recipe_bookmark = Bookmark.where(recipe_id: @recipe)
    @current_user_bookmarks = Bookmark.where(user: current_user)
  end
end
