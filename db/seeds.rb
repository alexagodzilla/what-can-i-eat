# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require "json"
require "faker"


puts "Cleaning database..."
puts "destroying all user ingredients"
UserIngredient.destroy_all
puts "destroying all recipe ingredients"
RecipeIngredient.destroy_all
puts "destroying all ingredients"
Ingredient.destroy_all
puts "destroying all bookmarks"
Bookmark.destroy_all
puts "destroying all reviews"
Review.destroy_all
puts "destroying all recipes"
Recipe.destroy_all
puts "destroying all users"
User.destroy_all


puts "reading json file"


file = File.read("#{Rails.root}/public/recipe_api_data.json")
recipes = JSON.parse(file, symbolize_names: true)[:recipes]
puts "creating recipes"
recipes.each do |recipe|
  puts "creating recipe #{recipe[:title]}"
  if recipe[:image].nil?
    recipe[:image] = "https://unsplash.com/photos/ZrhtQyGFG6s"
  end
new_recipe = Recipe.create!(
    title: recipe[:title],
    instructions: recipe[:instructions],
    # prep_time: recipe[:preparationMinutes],
    # cooking_time: recipe[:cookingMinutes],
    total_time: recipe[:readyInMinutes],
    serving_size: recipe[:servings],
    image_url: recipe[:image],
    vegetarian: recipe[:vegetarian],
    vegan: recipe[:vegan],
    dairy_free: recipe[:dairyFree],
    gluten_free: recipe[:glutenFree],

  )
  recipe[:extendedIngredients].each do |api_ingredient|
    db_ingredient = Ingredient.find_by(name: api_ingredient['name'])
      if db_ingredient.nil?
        db_ingredient = Ingredient.create!(
        name: api_ingredient[:name],
        # amount: ingredient['amount'],
        quantity_unit: api_ingredient[:measures][:metric][:unitShort]
      )
    end
        RecipeIngredient.create!(
        quantity: api_ingredient[:amount],
        recipe_id: new_recipe.id,
        ingredient_id: db_ingredient.id
      )
  end
end

puts "creating users"

15.times do
  User.create!(
  first_name: Faker::Name.unique.first_name,
  last_name: Faker::Name.unique.last_name,
  username: Faker::Internet.unique.username,
  email: Faker::Internet.unique.email,
  password: "password123456"
  # password: Faker::Alphanumeric.alpha(number: 10)
)
puts "created user #{User.last.username}"
end

puts "creating user_ingredients"

5.times do
  user = User.all.sample
  ingredient_ids = Ingredient.all.pluck(:id).sample(5)
  ingredient_ids.each do |ingredient_id|
    UserIngredient.create!(
      user_id: user.id,
      ingredient_id: ingredient_id
    )
    puts "created user_ingredient #{UserIngredient.last.id} for user #{user.username} with ingredient_id #{ingredient_id}"
  end
end


puts "creating bookmarks"

75.times do
  Bookmark.create!(
    user_id: User.all.sample.id,
    recipe_id: Recipe.all.sample.id
  )
  puts "created bookmark #{Bookmark.last.id}"
end

puts "creating reviews"

75.times do
  Review.create!(
    user_id: User.all.sample.id,
    recipe_id: Recipe.all.sample.id,
    content: Faker::TvShows::GameOfThrones.quote,
    rating: rand(3..5)
  )
  puts "created review #{Review.last.id}"
end
