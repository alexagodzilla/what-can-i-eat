require "json"
require "faker"
require 'action_view'
include ActionView::Helpers::SanitizeHelper

# for demo purposes
twenty_avatar_imgs = [
  "https://randomuser.me/api/portraits/men/32.jpg",
  "https://randomuser.me/api/portraits/men/29.jpg",
  "https://randomuser.me/api/portraits/men/35.jpg",
  "https://randomuser.me/api/portraits/men/4.jpg",
  "https://randomuser.me/api/portraits/men/22.jpg",
  "https://randomuser.me/api/portraits/men/12.jpg",
  "https://randomuser.me/api/portraits/men/52.jpg",
  "https://images.unsplash.com/photo-1455354269813-737d9df115bb?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=200&fit=max&s=1229aa0db2a9a42022b7669f30784123",
  "https://images.unsplash.com/photo-1502452213786-a5bc0a67e963?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=200&fit=max&s=8474b116817dfa40dc19c9349a16ee5a",
  "https://images.pexels.com/photos/450212/pexels-photo-450212.jpeg?h=350&auto=compress&cs=tinysrgb",
  "https://randomuser.me/api/portraits/men/84.jpg",
  "https://randomuser.me/api/portraits/men/16.jpg",
  "https://images.unsplash.com/photo-1474533410427-a23da4fd49d0?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=200&fit=max&s=ee9537f6365657688885825712e3349d",
  "https://images.unsplash.com/photo-1503593245033-a040be3f3c82?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=200&fit=max&s=ca8c652b62b1f14c9c4c969289a8b33c",
  "https://randomuser.me/api/portraits/women/44.jpg",
  "https://images.unsplash.com/photo-1493666438817-866a91353ca9?ixlib=rb-0.3.5&q=80&fm=jpg&crop=faces&fit=crop&h=200&w=200&s=b616b2c5b373a80ffc9636ba24f7a4a9",
  "https://randomuser.me/api/portraits/women/63.jpg",
  "https://images.unsplash.com/photo-1510227272981-87123e259b17?ixlib=rb-0.3.5&q=80&fm=jpg&crop=faces&fit=crop&h=200&w=200&s=3759e09a5b9fbe53088b23c615b6312e",
  "https://randomuser.me/api/portraits/women/47.jpg",
  "https://randomuser.me/api/portraits/women/95.jpg",
  "https://randomuser.me/api/portraits/women/79.jpg",
  "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-0.3.5&q=80&fm=jpg&crop=faces&fit=crop&h=200&w=200&s=046c29138c1335ef8edee7daf521ba50",
  "https://images.unsplash.com/photo-1520813792240-56fc4a3765a7?ixlib=rb-1.2.1&q=80&fm=jpg&crop=faces&fit=crop&h=200&w=200&ixid=eyJhcHBfaWQiOjE3Nzg0fQ",
  "https://images.unsplash.com/photo-1511485977113-f34c92461ad9?ixlib=rb-1.2.1&q=80&fm=jpg&crop=faces&fit=crop&h=200&w=200&ixid=eyJhcHBfaWQiOjE3Nzg0fQ",
  "https://randomuser.me/api/portraits/women/8.jpg",
  "https://images.unsplash.com/photo-1520810627419-35e362c5dc07?ixlib=rb-1.2.1&q=80&fm=jpg&crop=faces&fit=crop&h=200&w=200&ixid=eyJhcHBfaWQiOjE3Nzg0fQ",
  "https://randomuser.me/api/portraits/women/9.jpg",
  "https://images.unsplash.com/photo-1496081081095-d32308dd6206?ixlib=rb-0.3.5&q=80&fm=jpg&crop=faces&fit=crop&h=200&w=200&s=dd302358c7e18c27c4086e97caf85781",
  "https://images.pexels.com/photos/598745/pexels-photo-598745.jpeg?crop=faces&fit=crop&h=200&w=200&auto=compress&cs=tinysrgb",
  "https://images.unsplash.com/photo-1546539782-6fc531453083?ixlib=rb-1.2.1&q=80&fm=jpg&crop=faces&fit=crop&h=200&w=200&ixid=eyJhcHBfaWQiOjE3Nzg0fQ",
  "https://api.uifaces.co/our-content/donated/AVQ0V28X.jpg",
  "https://randomuser.me/api/portraits/women/33.jpg",
  "https://images.pexels.com/photos/325531/pexels-photo-325531.jpeg?h=350&auto=compress&cs=tinysrgb",
  "https://images.unsplash.com/photo-1465406325903-9d93ee82f613?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=200&fit=max&s=5eb9f23d01faf52817ff797530242521"
]

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
puts "destroying chatroom"
Chatroom.destroy_all
puts "destroying all users"
User.destroy_all

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

puts "creating users"
20.times do
  User.create!(
    first_name: Faker::Name.unique.first_name,
    last_name: Faker::Name.unique.last_name,
    username: Faker::Internet.unique.username,
    email: Faker::Internet.unique.email,
    password: "123456",
    bio: Faker::Hipster.paragraph(sentence_count: 2),
    diet: ["Vegetarian", "Vegan", "Gluten Free", "Dairy Free", "Everything"].sample,
    image_url: twenty_avatar_imgs.sample
  )
end

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

puts "creating chatroom"
Chatroom.create!(name: "Main Room")

puts "creating Alex (alex@me.com)"
Alex = User.create!(
  first_name: "Alex",
  last_name: "Agozzino",
  username: Faker::Internet.unique.username,
  email: "alex@me.com",
  password: "123456",
  bio: Faker::Hipster.paragraph(sentence_count: 2),
  diet: "Gluten Free",
  image_url: "https://avatars.githubusercontent.com/u/59085737?v=4"
)

puts "creating Alex's gluten-free bookmarks"
3.times do
  recipe_id = Recipe.where(gluten_free: true).sample.id
  next if Bookmark.where(recipe_id:).exists?

  Bookmark.create!(
    user_id: Alex.id,
    recipe_id:
  )
end

puts "creating Alex's user_ingredients"
garlic_id = Ingredient.find_by(name: "Garlic").id
thyme_id = Ingredient.find_by(name: "Thyme").id
cumin_id = Ingredient.find_by(name: "Cumin").id

[garlic_id, thyme_id, cumin_id].each do |ingredient_id|
  UserIngredient.create!(
    user_id: Alex.id,
    ingredient_id:
  )
end

puts "creating Fran (fran@me.com)"
Fran = User.create!(
  first_name: "Fran",
  last_name: "Sandford",
  username: Faker::Internet.unique.username,
  email: "fran@me.com",
  password: "123456",
  bio: Faker::Hipster.paragraph(sentence_count: 2),
  diet: "Everything",
  image_url: "https://avatars.githubusercontent.com/u/114738789?v=4"
)

puts "creating Ila (ila@me.com)"
Ila = User.create!(
  first_name: "Ila",
  last_name: "Peroni",
  username: Faker::Internet.unique.username,
  email: "ila@me.com",
  password: "123456",
  bio: Faker::Hipster.paragraph(sentence_count: 2),
  diet: "Gluten Free",
  image_url: "https://avatars.githubusercontent.com/u/114817089?v=4"
)

puts "creating Jon (jon@me.com)"
Jon = User.create!(
  first_name: "Jon",
  last_name: "Dedman",
  username: Faker::Internet.unique.username,
  email: "jon@me.com",
  password: "123456",
  bio: Faker::Hipster.paragraph(sentence_count: 2),
  diet: "Everything",
  image_url: "https://avatars.githubusercontent.com/u/110668469?v=4"
)

puts "creating friendship between Alex and Fran"
Friendship.create!(
  requester_id: Alex.id,
  requested_id: Fran.id,
  status: "accepted"
)

puts "creating friendship between Alex and Ila"
Friendship.create!(
  requester_id: Alex.id,
  requested_id: Ila.id,
  status: "accepted"
)

puts "creating friendship between Alex and Jon"
Friendship.create!(
  requester_id: Alex.id,
  requested_id: Jon.id,
  status: "accepted"
)

puts "seeding done"
