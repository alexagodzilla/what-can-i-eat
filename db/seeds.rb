require "json"
require "faker"
require 'action_view'
include ActionView::Helpers::SanitizeHelper

puts "cleaning database..."
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
puts "destroying all messages"
Message.destroy_all
puts "destroying all chatrooms"
Chatroom.destroy_all
puts "destroying all users"
User.destroy_all

puts "reading json files"
json_names = %w[vegetarian_recipes vegan_recipes gluten_free_recipes dairy_free_recipes recipe_api_data]
json_names.each do |file_name|
  recipes = JSON.parse(File.read("#{Rails.root}/public/#{file_name}.json"), symbolize_names: true)[:recipes]

  puts "creating recipes"
  recipes.each do |recipe|
    db_recipe = Recipe.find_by(title: recipe[:title])
    if db_recipe.nil?

  puts "creating recipe #{recipe[:title]}"
  recipe[:image].nil? ? img = "/assets/kelsey-chance-ZrhtQyGFG6s-unsplash.jpg" : img = recipe[:image]
  db_recipe = Recipe.create!(
    title: recipe[:title],
    instructions: strip_tags(recipe[:instructions]).gsub(/(\w+)\.(\w+)/, '\1. \2'),
    # prep_time: recipe[:preparationMinutes],
    # cooking_time: recipe[:cookingMinutes],
    total_time: recipe[:readyInMinutes],
    serving_size: recipe[:servings],
    image_url: img,
    vegetarian: recipe[:vegetarian],
    vegan: recipe[:vegan],
    dairy_free: recipe[:dairyFree],
    gluten_free: recipe[:glutenFree]
  )
  puts "creating steps"
  recipe[:analyzedInstructions][0][:steps].each do |step|
    step = Step.create!(
      number: step[:number],
      content: step[:step],
      recipe_id: db_recipe.id
    )
  end
  puts "creating ingredients"

      recipe[:extendedIngredients].each do |api_ingredient|
        db_ingredient = Ingredient.find_by(name: api_ingredient[:name].capitalize.gsub(/\d+/, '').strip)
        if db_ingredient.nil?
          if api_ingredient[:unit] == "cup" || api_ingredient[:unit] == "cups"
            unit = api_ingredient[:unit].downcase
          else
            unit = api_ingredient[:measures][:metric][:unitShort].downcase
          end
          db_ingredient = Ingredient.create!(
            name: api_ingredient[:name].capitalize.gsub(/\d+/, '').strip,
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
    first_name: (Faker::Name.unique.first_name).capitalize,
    last_name: (Faker::Name.unique.last_name).capitalize,
    username: Faker::Internet.unique.username,
    email: Faker::Internet.unique.email,
    password: "123456"
  )
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
  end
end

puts "creating bookmarks"
75.times do
  recipe_id = Recipe.all.sample.id
  if Bookmark.where(recipe_id:).empty?
    Bookmark.create!(
      user_id: User.all.sample.id,
      recipe_id:
    )
  end
end

puts "creating reviews"
200.times do
  Review.create!(
    user_id: User.all.sample.id,
    recipe_id: Recipe.all.sample.id,
    content: Faker::TvShows::GameOfThrones.quote,
    rating: rand(3..5)
  )
end

puts "creating chatroom"
Chatroom.create!(name: "Main Room")
