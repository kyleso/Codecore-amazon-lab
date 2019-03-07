# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
PASSWORD = "supersecret"

Review.destroy_all
Product.destroy_all
User.destroy_all
Like.destroy_all

30.times do
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  User.create(
    first_name: first_name,
    last_name: last_name,
    email: "#{first_name.downcase}.#{last_name.downcase}@example.com",
    password: PASSWORD,
  )
end

users = User.all

1000.times do
  created_at = Faker::Date.backward(365)

  p = Product.create(
    title: Faker::Appliance.equipment,
    description: Faker::Hipster.sentence,
    price: rand(1..100),
    created_at: created_at,
    updated_at: created_at,
    user: users.sample,
  )

  if p.valid?
    r = Review.create(body: Faker::GreekPhilosophers.quote, rating: rand(1..5), user: users.sample, product: p)
    if r.valid?
      r.likers = users.shuffle.slice(0, rand(users.count))
    end
  end
end
