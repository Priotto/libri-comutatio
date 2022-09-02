Trade.destroy_all
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
  books = Book.get_book_attributes(Faker::Book.title)
  puts "###############LIVRO#############:   #{books}"


  Book.create!(title: books.first[:title],
              author: books.first[:author],
              thumbnail:books.first[:thumbnail],
              published_date: books.first[:published_date],
              synopsis: books.first[:synopsis],
              rating: 5,
              latitude: Faker::Address.latitude,
              longitude: Faker::Address.longitude,
              description: 'Brand new',
              user: User.all.sample)
end

puts 'books created'
