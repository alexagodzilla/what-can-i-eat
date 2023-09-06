puts "Creating reviews"
Recipe.all.each do |recipe|
  rand(3..5).times do
    Review.create!(
      user_id: User.all.sample.id,
      recipe_id: recipe.id,
      content: Faker::TvShows::GameOfThrones.quote,
      rating: rand(3..5)
    )
  end
end
