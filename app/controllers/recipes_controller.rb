class RecipesController < ApplicationController
  def index
    if params[:query].present?
      if params[:ingredient_id].present?
        user_ingredients(params[:ingredient_id])
      else
        inserted_ingredients
      end
    elsif params.values.include?("1") && params[:query].empty?
      checked = params.select { |_key, value| value == "1" }.keys
      @recipes = Recipe.where(checked.to_h { |value| [value, true] })
    else
      @recipes = Recipe.last(5)
    end
  end

  def show
    @bookmark = Bookmark.new
    @review = Review.new
    @recipe = Recipe.find(params[:id])
    @current_user_bookmarks = Bookmark.where(user: current_user)
  end

  private

  def user_ingredients(array)
    array.map! { |ingredient_id| Ingredient.find(ingredient_id).name }.join(" ")
    if params.values.include?("1")
      checked = params.select { |_key, value| value == "1" }.keys
      @recipes = Recipe.search_recipes("#{params[:query]} #{str}").where(checked.to_h { |value| [value, true] })
    else
      @recipes = Recipe.search_recipes("#{params[:query]} #{str}")
    end
  end

  def inserted_ingredients
    if params.values.include?("1")
      checked = params.select { |_key, value| value == "1" }.keys
      @recipes = Recipe.search_recipes(params[:query]).where(checked.to_h { |value| [value, true] })
    else
      @recipes = Recipe.search_recipes(params[:query])
    end
  end
end
