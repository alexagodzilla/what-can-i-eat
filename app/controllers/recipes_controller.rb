class RecipesController < ApplicationController
  def index
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  private

  def recipe_params
    params.require(:recipe).permit(:title, :instructions, :total_time, :serving_size, :image_url,
                                   :vegetarian, :vegan, :dairy_free, :gluten_free)
  end
end

# pls note that i've not included prep_time and cooking_time in params for now
