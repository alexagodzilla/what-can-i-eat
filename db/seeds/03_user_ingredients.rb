puts "creating user_ingredients"
10.times do
  user = User.all.sample
  ingredient_ids = Ingredient.all.pluck(:id).sample(5)
  ingredient_ids.each do |ingredient_id|
    UserIngredient.create!(
      user_id: user.id,
      ingredient_id:
    )
  end
end

puts "creating Alex's user_ingredients"
garlic_id = Ingredient.find_by(name: "Garlic").id
thyme_id = Ingredient.find_by(name: "Thyme").id
cumin_id = Ingredient.find_by(name: "Cumin").id
[garlic_id, thyme_id, cumin_id].each do |ingredient_id|
  UserIngredient.create!(
    user_id: ALEX.id,
    ingredient_id:
  )
end
