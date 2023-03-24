if @review.persisted?
  json.form render(partial: "recipes/form", formats: :html, locals: { recipe: @recipe, review: Review.new })
  json.inserted_item render(partial: "recipes/review", formats: :html, locals: { review: @review })
else
  json.form render(partial: "recipes/form", formats: :html, locals: { recipe: @recipe, review: @review })
end
