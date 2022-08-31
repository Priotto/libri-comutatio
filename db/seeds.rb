Book.destroy_all
User.destroy_all

puts 'creating users'

10.times do
  User.create!(firstname: Faker::Name.first_name,
               lastname: Faker::Name.last_name,
               username: Faker::Internet.username,
               email: Faker::Internet.email,
               address: Faker::Address.full_address,
               password: '*******')
end

puts 'users created'

puts 'creating books'

10.times do
  book = Book.create!(title: 'Lord of the Rings',
                      author: 'J. R. R. Tolkien',
                      photo: 'https://images-na.ssl-images-amazon.com/images/I/51kfFS5-fnL._SX332_BO1,204,203,200_.jpg',
                      year: '1954',
                      synopsis: "In ancient times the Rings of Power were crafted by the Elven-smiths, and Sauron, the Dark Lord, forged the One Ring, filling it with his own power so that he could rule all others. But the One Ring was taken from him, and though he sought it throughout Middle-earth, it remained lost to him. After many ages it fell by chance into the hands of the hobbit Bilbo Baggins.",
                      rating: 5,
                      latitude: Faker::Address.latitude,
                      longitude: Faker::Address.longitude,
                      description: 'Brand new',
                      user: User.all.sample)
end

puts 'books created'
