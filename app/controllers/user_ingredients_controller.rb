class UserIngredientsController < ApplicationController
  def index
    @user_ingredients = UserIngredient.where(user: current_user)
    @user_ingredient = UserIngredient.new
  end

  def create
    @user_ingredient = UserIngredient.new(user_ingredient_params)
    @user_ingredient.user = current_user
    redirect_to profile_ingredients_path if @user_ingredient.save!
  end

  def destroy
    @user_ingredient = UserIngredient.find(params[:id])
    @user_ingredient.destroy
    redirect_to profile_ingredients_path
  end

  private

  def user_ingredient_params
    params.require(:user_ingredient).permit(:quantity, :ingredient_id)
  end
end
