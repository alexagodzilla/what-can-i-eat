puts "creating Alex's gluten-free bookmarks"
3.times do
  recipe_id = Recipe.where(gluten_free: true).sample.id
  next if Bookmark.where(recipe_id:).exists?

  Bookmark.create!(
    user_id: ALEX.id,
    recipe_id:
  )
end
