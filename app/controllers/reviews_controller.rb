class ReviewsController < ApplicationController
  before_action :set_review, only: %i[update destroy]

  def create
    @recipe = Recipe.find(params[:recipe_id])
    @review = Review.new(review_params)
    @review.user = current_user
    @review.recipe = @recipe
    if @review.save!
      redirect_to recipe_path(@recipe), notice: "Comment added"
    else
      render "recipes/show", status: :unprocessable_entity
    end
  end

  def update
    @recipe = Recipe.find(params[:recipe_id])
    @review.update(review_params)
    redirect_to recipe_path(@recipe)
  end

  def destroy
    @review.destroy
    redirect_to recipe_path(@review.recipe), notice: "Comment deleted"
  end

  private

  def set_review
    @review = Review.find(params[:id])
  end

  def review_params
    params.require(:review).permit(:content, :rating)
  end
end
