class RecipesController < ApplicationController
  def index
    if params[:query].present?
      params[:ingredient_id].present? ? search(params[:query], params[:ingredient_id]) : search(params[:query])
    elsif params[:ingredient_id].present?
      search("", params[:ingredient_id])
    elsif params.values.include?("1") && params[:query].empty?
      empty_query
    else
      @recipes = Recipe.last(5)
    end
    @low_to_high = params[:order] == "Low to High"
  end

  def show
    # To find the chatroom from the recipe show page
    @chatroom = Chatroom.first
    @bookmark = Bookmark.new
    @review = Review.new
    @recipe = Recipe.find(params[:id])
    @user_bookmarks = Bookmark.where(user: current_user)
  end

  private

  def search(params_query, user_ingredient = "")
    user_ingredient.map! { |id| Ingredient.find(id).name }.join(" ") if user_ingredient.length.positive?
    if params.values.include?("1")
      arr = params.select { |_key, value| value == "1" }.keys
      @recipes = Recipe.search_recipes("#{params_query} #{user_ingredient}").where(arr.to_h { |key| [key, true] })
    else
      @recipes = Recipe.search_recipes("#{params_query} #{user_ingredient}")
    end
  end

  def empty_query
    arr = params.select { |_key, value| value == "1" }.keys
    @recipes = Recipe.where(arr.to_h { |key| [key, true] })
  end
end
