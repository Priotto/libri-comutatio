class Book < ApplicationRecord
  belongs_to :user

  scope :available, -> { where("available = ?", true) }

  def trade!
    self.update_attribute("available", false)
  end

  def self.get_book_attributes(title = "", author = "")
    response = Books.call(title, author)

    response["items"].each do |element|
      # puts "Nome do livro: #{element["volumeInfo"]["title"]}"
      # puts "Nome do autor: #{element["volumeInfo"]["authors"].first} "
      # puts "Editora: #{element["volumeInfo"]["publisher"]}"
      # puts "Ano de lançamento: #{element["volumeInfo"]["publishedDate"]}"
      # puts "Thumbnail: #{element["volumeInfo"]["imageLinks"]["smallThumbnail"]}"
      # puts "#####################################################"
    end
    return response
  end
end
