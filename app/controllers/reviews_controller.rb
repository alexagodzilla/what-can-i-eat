class ReviewsController < ApplicationController
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
  end

  def destroy
  end

  private

  def review_params
    params.require(:review).permit(:content, :rating)
  end
end
