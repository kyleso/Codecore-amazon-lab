# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Review.destroy_all
Product.destroy_all

1000.times do

created_at = Faker::Date.backward(365)

p = Product.create(
  title: Faker::Appliance.equipment,
  description: Faker::Hipster.sentence,
  price: rand(1..100),
  created_at: created_at,
  updated_at: created_at
)

  if p.valid?
    p.reviews = rand(0..25).times.map do
      Review.new(body: Faker::GreekPhilosophers.quote, rating: rand(1..5))
    end
  end
end


