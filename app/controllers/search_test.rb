def search
  @ingredients = ["onion", "chicken"].map { |name| Ingredient.find_by(name: name)}.capitalize
puts @ingredients
  end

end
