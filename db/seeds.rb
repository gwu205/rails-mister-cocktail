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

cocktails = [
    'Amber Moon',
    'Blue Blazer',
    'Brooklyn',
    'Jack and Coke',
    'Scotch and soda',
    'Whisky Mac'
]

img = [
    'https://images.unsplash.com/photo-1554420026-54be86d931f8?crop=entropy&cs=tinysrgb&fit=crop&fm=jpg&h=900&ixid=eyJhcHBfaWQiOjF9&ixlib=rb-1.2.1&q=80&w=1600',
    'https://images.unsplash.com/photo-1554219962-f71d858fa121?crop=entropy&cs=tinysrgb&fit=crop&fm=jpg&h=900&ixid=eyJhcHBfaWQiOjF9&ixlib=rb-1.2.1&q=80&w=1600',
    'https://images.unsplash.com/photo-1542518392-13317b1ee2a2?crop=entropy&cs=tinysrgb&fit=crop&fm=jpg&h=900&ixid=eyJhcHBfaWQiOjF9&ixlib=rb-1.2.1&q=80&w=1600',
    'https://images.unsplash.com/photo-1455621481073-d5bc1c40e3cb?crop=entropy&cs=tinysrgb&fit=crop&fm=jpg&h=900&ixid=eyJhcHBfaWQiOjF9&ixlib=rb-1.2.1&q=80&w=1600',
    'https://images.unsplash.com/photo-1455621481073-d5bc1c40e3cb?crop=entropy&cs=tinysrgb&fit=crop&fm=jpg&h=900&ixid=eyJhcHBfaWQiOjF9&ixlib=rb-1.2.1&q=80&w=1600',
    'https://images.unsplash.com/photo-1564957468535-e8e51b0d2f56?crop=entropy&cs=tinysrgb&fit=crop&fm=jpg&h=900&ixid=eyJhcHBfaWQiOjF9&ixlib=rb-1.2.1&q=80&w=1600'
]

6.times do
  photo = Cloudinary::Uploader.upload(img.shift)
  cocktail = Cocktail.create!(name: cocktails.shift, remote_photo_url: photo["secure_url"])
  5.times do
    Dose.create(description: rand(1..4), cocktail_id: cocktail.id, ingredient_id: Ingredient.all.sample.id)
  end
end
