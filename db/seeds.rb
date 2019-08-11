# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'open-uri'
require 'json'
require 'faker'

url = 'https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list'
ingredients_serialized = open("#{url}").read
ingredients = JSON.parse(ingredients_serialized)["drinks"]
ingredients.each { |ingredient| Ingredient.create(name: ingredient["strIngredient1"]) }

10.times do
  # photo = Cloudinary::Uploader.upload("https://source.unsplash.com/1600x900/?cocktail")
  cocktail = Cocktail.new(name: Faker::Coffee.blend_name, remote_photo_url: 'https://res.cloudinary.com/gswu205/image/upload/v1565338270/zlby7tqqb9pqlpirx7m5.jpg')
  cocktail.save!
  5.times do
    Dose.create(description: rand(1..4), cocktail_id: cocktail.id, ingredient_id: Ingredient.all.sample.id)
  end
end
