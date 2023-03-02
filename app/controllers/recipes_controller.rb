class RecipesController < ApplicationController
  def index
    if params[:query].present?
      @recipes = Recipe.search_by_title_and_instructions(params[:query])
      # @recipes = @recipes.with_ingredients(params[:ingredients].split(',')) if params[:ingredients].present?
    else
      @recipes = Recipe.all
    end
  end

  def show
    @bookmark = Bookmark.new
    @review = Review.new
    @recipe = Recipe.find(params[:id])
    @current_user_bookmarks = Bookmark.where(user: current_user)
  end
end
