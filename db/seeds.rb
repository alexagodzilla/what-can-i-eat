require "json"
require "faker"
require 'action_view'
include ActionView::Helpers::SanitizeHelper

puts "cleaning database..."
puts "destroying all friendships"
Friendship.destroy_all
puts "destroying all user ingredients"
UserIngredient.destroy_all
puts "destroying all steps"
Step.destroy_all
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
json_names = %w[vegetarian_recipes vegan_recipes gluten_free_recipes dairy_free_recipes recipe_api_data chicken_recipes extra_dairy_free_recipes extra_vegetarian_recipes extra_vegan_recipes extra_gluten_free_recipes]
json_names.each do |file_name|
  recipes = JSON.parse(File.read("#{Rails.root}/public/#{file_name}.json"), symbolize_names: true)[:recipes]

  puts "creating recipes"
  recipes.each do |recipe|
    db_recipe = Recipe.find_by(title: recipe[:title])
    if db_recipe.nil?

    puts "creating recipe #{recipe[:title]}"
    recipe[:image].nil? ? img = "https://unsplash.com/photos/ZrhtQyGFG6s" : img = recipe[:image]
    recipe[:instructions].empty? ? instructions = recipe[:summary] : instructions = strip_tags(recipe[:instructions]).gsub(/(\w+)\.(\w+)/, '\1. \2')
    db_recipe = Recipe.create!(
      title: recipe[:title],
      instructions: instructions,
      # prep_time: recipe[:preparationMinutes],
      # cooking_time: recipe[:cookingMinutes],
      total_time: recipe[:readyInMinutes],
      serving_size: recipe[:servings],
      image_url: img,
      vegetarian: recipe[:vegetarian],
      vegan: recipe[:vegan],
      dairy_free: recipe[:dairyFree],
      gluten_free: recipe[:glutenFree],
      average_rating: 0.0
    )
    puts "creating steps"
    unless recipe[:analyzedInstructions].empty?
      recipe[:analyzedInstructions][0][:steps].each do |step|
        Step.create!(
          number: step[:number],
          content: step[:step],
          recipe_id: db_recipe.id
        )
      end
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
200.times do
  User.create!(
    first_name: Faker::Name.unique.first_name,
    last_name: Faker::Name.unique.last_name,
    username: Faker::Internet.unique.username,
    email: Faker::Internet.unique.email,
    password: "123456",
    bio: Faker::Hipster.paragraph(sentence_count: 2),
    diet: ["Vegetarian", "Vegan", "Gluten Free", "Dairy Free", "Everything"].sample,
    image_url: "https://source.unsplash.com/featured/?face"
  )
end

puts "creating user_ingredients"
100.times do
  user = User.all.sample
  ingredient_ids = Ingredient.all.pluck(:id).sample(5)
  ingredient_ids.each do |ingredient_id|
    UserIngredient.create!(
      user_id: user.id,
      ingredient_id:
    )
  end
end

# puts "creating bookmarks"
# 150.times do
#   recipe_id = Recipe.all.sample.id
#   if Bookmark.where(recipe_id:).empty?
#     Bookmark.create!(
#       user_id: User.all.sample.id,
#       recipe_id:
#     )
#   end
# end

puts "creating reviews"
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

# 200.times do
#   Review.create!(
#     user_id: User.all.sample.id,
#     recipe_id: Recipe.all.sample.id,
#     content: Faker::TvShows::GameOfThrones.quote,
#     rating: rand(3..5)
#   )
# end

# puts "creating friendships"
# User.all.each do |user|
#   rand(3..5).times do
#     friend = User.all.sample
#     unless user == friend || user.friends.include?(friend)
#       Friendship.create!(
#         requester_id: user.id,
#         requested_id: friend.id,
#         status: "accepted"
#       )
#     end
#   end
# end

puts "creating chatroom"
Chatroom.create!(name: "Main Room")

puts "creating Amie"
puts "amie's email is amie@me.com"
Amie = User.create!(
  first_name: "Amie",
  last_name: Faker::Name.unique.last_name,
  username: Faker::Internet.unique.username,
  email: "amie@me.com",
  password: "123456",
  bio: Faker::Hipster.paragraph(sentence_count: 2),
  diet: "Gluten Free",
  image_url: "https://source.unsplash.com/featured/?face"
)

puts "creating Amie's bookmarks"
puts "amie's bookmarks are gluten free recipes"
gluten_free_recipes = Recipe.where(gluten_free: true)

3.times do
  recipe_id = gluten_free_recipes.sample.id
  if Bookmark.where(recipe_id:).empty?
    Bookmark.create!(
      user_id: Amie.id,
      recipe_id:
    )
  end
end

puts "creating Amie's user_ingredients"


puts "creating Amie's friends"
puts "creating Fran"
puts "Fran's email is fran@me.com"
