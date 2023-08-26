include ActionView::Helpers::SanitizeHelper
require "json"

# methods used in create_recipes
def create_recipe_instructions(recipe, instructions)
  if instructions.nil?
    recipe[:summary]
  else
    strip_tags(recipe[:instructions]).gsub(/(\w+)\.(\w+)/, '\1. \2')
  end
end

def create_recipe(recipe, instructions)
  Recipe.create!(
    title: recipe[:title],
    instructions:,
    total_time: recipe[:readyInMinutes],
    serving_size: recipe[:servings],
    image_url: recipe[:image] || "https://unsplash.com/photos/ZrhtQyGFG6s",
    vegetarian: recipe[:vegetarian],
    vegan: recipe[:vegan],
    dairy_free: recipe[:dairyFree],
    gluten_free: recipe[:glutenFree],
    average_rating: 0.0
  )
end

def create_steps(recipe, new_db_recipe)
  recipe[:analyzedInstructions][0][:steps].each do |step|
    Step.create!(
      number: step[:number],
      content: step[:step],
      recipe_id: new_db_recipe.id
    )
  end
end

def create_ingredient(recipe, new_db_recipe)
  recipe[:extendedIngredients].each do |api_ingredient|
    db_ingredient = Ingredient.find_by(name: api_ingredient[:name].capitalize.gsub(/\d+/, '').strip)
    next unless db_ingredient.nil?

    ingredient(api_ingredient)
    next if new_db_recipe.ingredients.include?(db_ingredient) && db_ingredient.recipes.include?(new_db_recipe)

    recipe_ingredient(api_ingredient, new_db_recipe, db_ingredient)
  end
end

def ingredient(api_ingredient)
  if api_ingredient[:unit].include?("cup")
    unit = api_ingredient[:unit].downcase
  else
    unit = api_ingredient[:measures][:metric][:unitShort].downcase
  end
  Ingredient.create!(
    name: api_ingredient[:name].capitalize.gsub(/\d+/, '').strip,
    quantity_unit: unit
  )
end

def recipe_ingredient(api_ingredient, new_db_recipe, db_ingredient)
  RecipeIngredient.create!(
    quantity: api_ingredient[:amount],
    recipe_id: new_db_recipe.id,
    ingredient_id: db_ingredient.id
  )
end

# the seeding
def create_recipes(recipes)
  recipes.each do |recipe|
    next unless Recipe.find_by(title: recipe[:title]).nil?

    instructions = create_recipe_instructions(recipe, recipe[:instructions])
    new_db_recipe = create_recipe(recipe, instructions)
    create_steps(recipe, new_db_recipe) unless recipe[:analyzedInstructions].empty?
    create_ingredient(recipe, new_db_recipe)
  end
end

["vegetarian_recipes", "recipe_api_data"].each do |file_name|
  puts "Reading JSON file"
  root_path = "#{Rails.root}/public/recipes_data/#{file_name}.json"
  recipes = JSON.parse(File.read(root_path), symbolize_names: true)[:recipes]
  puts "Creating recipes from #{file_name}"
  create_recipes(recipes)
end
