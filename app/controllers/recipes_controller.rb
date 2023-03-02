class RecipesController < ApplicationController
  def index
    if params[:query].present?
      if params.values.include?("1")
        checked = params.select { |_key, value| value == "1" }.keys.map { |key| "#{key} = true" }.join(", ")
        @recipes = Recipe.search_recipes(params[:query]).where(checked)
      else
        @recipes = Recipe.search_recipes(params[:query])
      end
    else
      @recipes = Recipe.all
    end
  end
  # need to implement logic for when no recipes appear - as per ilaria's advice, switch statement

  def show
    @bookmark = Bookmark.new
    @review = Review.new
    @recipe = Recipe.find(params[:id])
    @current_user_bookmarks = Bookmark.where(user: current_user)
  end
end

# @recipes.with_ingredients(params[:ingredients].split(',')) if params[:ingredients].present?
