class RecipesController < ApplicationController
  def index
    if params[:query].present?
      @recipes = Recipe.search_by_title_and_instructions(params[:query])
      # @recipes = @recipes.search(params[:query]) if params[:query].present?
      # @recipes = @recipes.vegetarian if params[:vegetarian].present?
      # @recipes = @recipes.vegan if params[:vegan].present?
      # @recipes = @recipes.gluten_free if params[:gluten_free].present?
      # @recipes = @recipes.dairy_free if params[:dairy_free].present?
      # @recipes = @recipes.with_total_time(params[:total_time]) if params[:total_time].present?
      # @recipes = @recipes.with_ingredients(params[:ingredients].split(',')) if params[:ingredients].present?
      # @recipes = @recipes.sorted_by(params[:sort_by]) if params[:sort_by].present?
    else
      @recipes = Recipe.all
      # @recipes = @recipes.search(params[:query]) if params[:query].present?
      # @recipes = @recipes.vegetarian if params[:vegetarian].present?
      # @recipes = @recipes.vegan if params[:vegan].present?
      # @recipes = @recipes.gluten_free if params[:gluten_free].present?
      # @recipes = @recipes.dairy_free if params[:dairy_free].present?
      # @recipes = @recipes.with_total_time(params[:total_time]) if params[:total_time].present?
      # @recipes = @recipes.with_ingredients(params[:ingredients].split(',')) if params[:ingredients].present?
      # @recipes = @recipes.sorted_by(params[:sort_by]) if params[:sort_by].present?
  end
  end

  def show
    @bookmark = Bookmark.new
    @review = Review.new
    @recipe = Recipe.find(params[:id])
    @current_user_bookmarks = Bookmark.where(user: current_user)
  end
end
