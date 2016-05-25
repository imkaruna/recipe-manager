# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Ingredient.destroy_all
Ingredient.create(name: "Onion")
Ingredient.create(name: "Potato")
Ingredient.create(name: "Chicken")
Ingredient.create(name: "Pork")
Ingredient.create(name: "Rice")
Ingredient.create(name: "Orange")
