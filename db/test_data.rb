require "open-uri"
require "json"
require 'dotenv/load'
require_relative '../config/environment'


api_key = ENV.fetch('SPOONACULAR_API_KEY')

# https://api.spoonacular.com/recipes/716429/information?apiKey=YOUR-API-KEY&includeNutrition=true
url = "https://api.spoonacular.com/recipes/random?apiKey=#{api_key}&number=100"

response = URI.open(url).read

data = JSON.parse(response)
puts data
# # Access the data
# puts data['field1']
# puts data['field2']
File.open("#{Rails.root}/public/recipe_api_data.json", "w") do |file|
  file.write(JSON.pretty_generate(data))
end
