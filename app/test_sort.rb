require relative: "./controllers/recipes_controller"

@recipes = Recipe.all

@recipes.each do |recipe|
  puts recipe.title
end
