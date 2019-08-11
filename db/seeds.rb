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
    'Black Nail',
    'Bobby Burns',
    'Boulevardier',
    'Bourbon Lancer',
    'Brooklyn',
    'Churchill',
    'Farnell',
    'Irish coffee IBA',
    'Horsefeather',
    'Jack and Coke',
    'Jungle Juice',
    'Lynchburg Lemonade',
    'Manhattan IBA',
    'Mint Julep IBA',
    'Missouri Mule',
    'Nixon',
    'Old Fashioned IBA',
    'Rob Roy',
    'Rusty Nail IBA',
    'Sazerac IBA',
    'Scotch and soda',
    'Seven and Seven or 7 & 7',
    'Three Wise Men',
    'Toronto',
    'Ward 8',
    'Whisky Mac',
    'Whiskey smash',
    'Whiskey sour IBA'
]

10.times do |i|
  # photo = Cloudinary::Uploader.upload("https://source.unsplash.com/1600x900/?cocktail")
  cocktail = Cocktail.new(name: cocktails.delete(cocktails.sample), remote_photo_url: `https://source.unsplash.com/1600x900/?cocktail/#{i}`)
  cocktail.save!
  5.times do
    Dose.create(description: rand(1..4), cocktail_id: cocktail.id, ingredient_id: Ingredient.all.sample.id)
  end
end
