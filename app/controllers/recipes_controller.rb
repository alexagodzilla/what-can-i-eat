class RecipesController < ApplicationController
  def index
    @recipes = Recipe.all
  end

  def show
    @bookmark = Bookmark.new
    @recipe = Recipe.find(params[:id])
  end
end
