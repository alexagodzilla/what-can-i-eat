class ReviewsController < ApplicationController
  before_action :set_review, only: [:update, :destroy]
  def create
    @recipe = Recipe.find(params[:recipe_id])
    @review = Review.new(review_params)
    @review.user = current_user
    @review.recipe = @recipe
    if @review.save!
      redirect_to recipe_path(@recipe), notice: "Comment successfully added"
    else
      render "recipes/show", status: :unprocessable_entity
    end
    # going to update the redirecting
  end

  def update
    @recipe_to_update = Recipe.find(params[:recipe_id])
    @review.update(review_params)
    redirect_to recipe_path(@recipe_to_update)
  end

  def destroy
  end

  private

  def set_review
    @review = Review.find(params[:id])
  end

  def review_params
    params.require(:review).permit(:content, :rating)
  end
end
