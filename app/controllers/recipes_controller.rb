class RecipesController < ApplicationController
  def index
    @recipes = Recipe.all

    if params[:search]
      @recipes = @recipes.search(params[:search])
    end

    if params[:vegetarian]
      @recipes = @recipes.vegetarian
    end

    if params[:vegan]
      @recipes = @recipes.vegan
    end

    if params[:gluten_free]
      @recipes = @recipes.gluten_free
    end

    if params[:dairy_free]
      @recipes = @recipes.dairy_free
    end

    if params[:total_time]
      @recipes = @recipes.with_total_time(params[:total_time])
    end

    if params[:ingredients]
      ingredient_names = params[:ingredients].split(',').map(&:strip)
      recipe_ids = Ingredient.where(name: ingredient_names).joins(:recipes).pluck(:recipe_id)
      @recipes = Recipe.where(id: recipe_ids).includes(:ingredients).distinct
    end

    if params[:sorted_by]
      @recipes = @recipes.sorted_by(params[:sorted_by])
    end

    # @recipes = @recipes.page(params[:page])

    respond_to do |format|
      format.html
      format.js
    end
  end

  def search_by_ingredients
    if params[:ingredients]
      ingredient_names = params[:ingredients].capitalize.split(',').map(&:strip)
      recipe_ids = Ingredient.where("name ILIKE ?", "%#{ingredient_names.first}%").joins(:recipes).pluck(:recipe_id)

      # loop through remaining ingredients and refine recipe list based on partial match
      ingredient_names[1..].each do |ingredient|
        recipe_ids &= Ingredient.where("name ILIKE ?", "%#{ingredient}%").joins(:recipes).pluck(:recipe_id)
      end
      @recipes = Recipe.where(id: recipe_ids).includes(:ingredients).distinct

      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(
            'recipes-list',
            partial: 'recipes/list',
            locals: { recipes: @recipes }
          )
        end
        format.html { render :index }
      end
    else
      @recipes = Recipe.all

      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(
            'recipes-list',
            partial: 'recipes/list',
            locals: { recipes: @recipes }
          )
        end
        format.html { render :index }
      end
    end
  end



  def show
    @bookmark = Bookmark.new
    @review = Review.new
    @recipe = Recipe.find(params[:id])
    @current_user_bookmarks = Bookmark.where(user: current_user)
  end
end
