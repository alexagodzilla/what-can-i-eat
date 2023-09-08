puts "Creating reviews"

def unique_id(id, array)
  if array.include?(id)
    unique_id(User.all.sample.id, array)
  end
  id
end

Recipe.all.each do |recipe|
  user_ids = []
  rand(3..5).times do
    review = Review.create!(
      user_id: unique_id(User.all.sample.id, user_ids),
      recipe_id: recipe.id,
      content: Faker::TvShows::GameOfThrones.quote,
      rating: rand(3..5)
    )
    user_ids << review.user_id
  end
end
