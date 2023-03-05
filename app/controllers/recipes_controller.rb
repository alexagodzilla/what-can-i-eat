class RecipesController < ApplicationController
  def index
    if params[:query].present?
      if params.values.include?("1")
        checked = params.select { |_key, value| value == "1" }.keys
        @recipes = Recipe.search_recipes(params[:query]).where(checked.to_h { |value| [value, true] })
      else
        @recipes = Recipe.search_recipes(params[:query])
      end
    else
      @recipes = Recipe.all
    end
  end

  def show
    @bookmark = Bookmark.new
    @review = Review.new
    @recipe = Recipe.find(params[:id])
    @user_bookmarks = Bookmark.where(user: current_user)
  end
end
