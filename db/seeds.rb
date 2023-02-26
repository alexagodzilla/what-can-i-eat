# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require "json"

puts "Cleaning database..."
puts "destroying all recipe ingredients"
RecipeIngredient.destroy_all
puts "destroying all ingredients"
Ingredient.destroy_all
puts "destroying all recipes"
Recipe.destroy_all


puts "reading json file"


file = File.read("#{Rails.root}/public/recipe_api_data.json")
recipes = JSON.parse(file, symbolize_names: true)[:recipes]
puts recipes[0][:title]
recipes.each do |recipe|
new_recipe = Recipe.create!(
    title: recipe[:title],
    instructions: recipe[:instructions],
    prep_time: recipe[:preparationMinutes],
    cooking_time: recipe[:cookingMinutes],
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
        quantity_unit: api_ingredient[:unit]
      )
    end
        RecipeIngredient.create!(
        quantity: api_ingredient[:amount],
        recipe_id: new_recipe.id,
        ingredient_id: db_ingredient.id
      )
  end
end
