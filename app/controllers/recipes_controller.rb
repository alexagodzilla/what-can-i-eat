class RecipesController < ApplicationController
  def index
  end

  def show
    @bookmark = Bookmark.new
    @recipe = Recipe.find(params[:id])
  end
end
