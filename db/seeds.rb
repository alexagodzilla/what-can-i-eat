require "json"
require "faker"
require 'action_view'

include ActionView::Helpers::SanitizeHelper

def remove_integer(ingredient_name)
  ingredient_name.gsub(/\d+/, '').strip
end

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

puts "reading json files"
json_names = %w(vegetarian_recipes vegan_recipes gluten_free_recipes dairy_free_recipes recipe_api_data)
json_names.each do |file_name|
file = File.read("#{Rails.root}/public/#{file_name}.json")
recipes = JSON.parse(file, symbolize_names: true)[:recipes]
puts "creating recipes"
recipes.each do |recipe|
  db_recipe = Recipe.find_by(title: recipe[:title])
    if db_recipe.nil?
  puts "creating recipe #{recipe[:title]}"
  recipe[:image] = "https://unsplash.com/photos/ZrhtQyGFG6s" if recipe[:image].nil?
  db_recipe = Recipe.create!(
    title: recipe[:title],
    # The following line is to fix the issue of the API not adding a space after a period and to remove the HTML tags
    # note the capture group in the regex. The first capture group is the word before the period and the second capture group is the word after the period
    # the \1 is the first capture group and the \2 is the second capture group.
    instructions: strip_tags(recipe[:instructions]).gsub(/(\w+)\.(\w+)/, '\1. \2'),
    # prep_time: recipe[:preparationMinutes],
    # cooking_time: recipe[:cookingMinutes],
    total_time: recipe[:readyInMinutes],
    serving_size: recipe[:servings],
    image_url: recipe[:image],
    vegetarian: recipe[:vegetarian],
    vegan: recipe[:vegan],
    dairy_free: recipe[:dairyFree],
    gluten_free: recipe[:glutenFree]
  )
  recipe[:extendedIngredients].each do |api_ingredient|
    db_ingredient = Ingredient.find_by(name: remove_integer(api_ingredient[:name]).capitalize)

    if db_ingredient.nil?

      # puts "ingredient #{api_ingredient[:name]} does not exist in db"
      if api_ingredient[:unit] == "cup" || api_ingredient[:unit] == "cups"
        unit = api_ingredient[:unit].downcase
      else
        unit = api_ingredient[:measures][:metric][:unitShort].downcase
      end
      db_ingredient = Ingredient.create!(
        name: remove_integer(api_ingredient[:name]).capitalize,
        # amount: ingredient['amount'],
        quantity_unit: unit
      )
    end
    unless db_recipe.ingredients.include?(db_ingredient) && db_ingredient.recipes.include?(db_recipe)
    RecipeIngredient.create!(
      quantity: api_ingredient[:amount],
      recipe_id: db_recipe.id,
      ingredient_id: db_ingredient.id
    )
  end
end
end
end
end
puts "creating users"

15.times do
  User.create!(
    first_name: Faker::Name.unique.first_name,
    last_name: Faker::Name.unique.last_name,
    username: Faker::Internet.unique.username,
    email: Faker::Internet.unique.email,
    password: "123456"
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
      ingredient_id:
    )
    puts "created user_ingredient #{UserIngredient.last.id} for user #{user.username} with ingredient_id #{ingredient_id}"
  end
end

puts "creating bookmarks"

75.times do
  recipe_id = Recipe.all.sample.id
  if Bookmark.where(recipe_id: recipe_id).empty?
  Bookmark.create!(
    user_id: User.all.sample.id,
    recipe_id: recipe_id
  )
  puts "created bookmark #{Bookmark.last.id}"
end
end

puts "creating reviews"

75.times do
  Review.create!(
    user_id: User.all.sample.id,
    recipe_id: Recipe.all.sample.id,
    content: Faker::TvShows::GameOfThrones.quote,
    rating: rand(1..5)
  )
  puts "created review #{Review.last.id}"
end
