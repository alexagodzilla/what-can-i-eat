puts "Cleaning database..."

models = [Friendship, UserIngredient, Step, RecipeIngredient, Bookmark,
          Review, Recipe, Message, Chatroom, User]
models.each do |model|
  model.destroy_all
  puts "Destroying all #{model}s"
end

Dir[Rails.root.join("db/seeds/*.rb")].each do |file|
  puts "PROCESSING SEED FILE: #{file.split('/').last.gsub('.rb', '')}"
  require file
end

puts "Creating chatroom"
Chatroom.create!(name: "Main Room")

puts "Seeding done"
