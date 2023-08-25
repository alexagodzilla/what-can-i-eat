include ActionView::Helpers::SanitizeHelper
require "json"

puts "reading json files"
["vegetarian_recipes", "recipe_api_data"].each do |file_name|
  root_path = "#{Rails.root}/public/recipes_data/#{file_name}.json"
  recipes = JSON.parse(File.read(root_path), symbolize_names: true)[:recipes]

  puts "creating recipes from #{file_name}"
  recipes.each do |recipe|
    next unless Recipe.find_by(title: recipe[:title]).nil?

    if recipe[:image].nil?
      img = "https://unsplash.com/photos/ZrhtQyGFG6s"
    else
      img = recipe[:image]
    end

    if recipe[:instructions].nil?
      instructions = recipe[:summary]
    else
      instructions = strip_tags(recipe[:instructions]).gsub(/(\w+)\.(\w+)/, '\1. \2')
    end

    new_db_recipe = Recipe.create!(
      title: recipe[:title],
      instructions:,
      total_time: recipe[:readyInMinutes],
      serving_size: recipe[:servings],
      image_url: img,
      vegetarian: recipe[:vegetarian],
      vegan: recipe[:vegan],
      dairy_free: recipe[:dairyFree],
      gluten_free: recipe[:glutenFree],
      average_rating: 0.0
    )

    unless recipe[:analyzedInstructions].empty?
      recipe[:analyzedInstructions][0][:steps].each do |step|
        Step.create!(
          number: step[:number],
          content: step[:step],
          recipe_id: new_db_recipe.id
        )
      end
    end

    recipe[:extendedIngredients].each do |api_ingredient|
      db_ingredient = Ingredient.find_by(name: api_ingredient[:name].capitalize.gsub(/\d+/, '').strip)
      if db_ingredient.nil?
        if api_ingredient[:unit].include?("cup")
          unit = api_ingredient[:unit].downcase
        else
          unit = api_ingredient[:measures][:metric][:unitShort].downcase
        end
        db_ingredient = Ingredient.create!(
          name: api_ingredient[:name].capitalize.gsub(/\d+/, '').strip,
          quantity_unit: unit
        )
      end

      unless new_db_recipe.ingredients.include?(db_ingredient) && db_ingredient.recipes.include?(new_db_recipe)
        RecipeIngredient.create!(
          quantity: api_ingredient[:amount],
          recipe_id: new_db_recipe.id,
          ingredient_id: db_ingredient.id
        )
      end
    end
  end
end
