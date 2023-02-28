class IngredientsController < ApplicationController
  def create
    @ingredient = Ingredient.new(ingredient_params)
    if @ingredient.save
      redirect_to profile_path, notice: 'Ingredient was successfully created.'
    else
      redirect_to profile_path, status: :unprocessable_entity
    end
    # will update that later
  end

  private

  def ingredient_params
    params.require(:ingredient).permit(:name, :quantity_unit)
  end
end
