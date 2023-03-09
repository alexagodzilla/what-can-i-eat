class UserIngredientsController < ApplicationController
  def index
    @user_ingredients = UserIngredient.where(user: current_user)
  end

  def new
    @user_ingredient = UserIngredient.new
  end

  def create
    @user_ingredient = UserIngredient.new(user_ingredient_params)
    @user_ingredient.user = current_user
    if @user_ingredient.save!
      redirect_to profile_path
      # update later
    else
      redirect_to profile_path, status: :unprocessable_entity
      # update later
    end
  end

  def destroy
    @user_ingredient = UserIngredient.find(params[:id])
    @user_ingredient.destroy
    redirect_to profile_path
    # update later
  end

  private

  def user_ingredient_params
    params.require(:user_ingredient).permit(:quantity, :ingredient_id)
  end
end
