class Books < ApplicationService
  attr_accessor :title

  def initialize(title)
    @title = title
    @key = ENV["BOOKS_API"]
  end

  def call
    unless @key.nil?
      url = "https://www.googleapis.com/books/v1/volumes?q=+intitle:#{@title}&key=#{@key}"
      uri = URI(url)
      fetch = Net::HTTP.get(uri)
      response = JSON.parse(fetch)
      digest(response)
    end
  end

  def digest(response)
    books_list = []
    response["items"].each do |element|
      book = Hash.new
      book[:title] = element["volumeInfo"]["title"]
      book[:author] = element["volumeInfo"]["authors"].first
      book[:publisher] = element["volumeInfo"]["publisher"]
      book[:synopsis] = element["volumeInfo"]["description"]
      book[:published_date] = element["volumeInfo"]["publishedDate"]
      element["volumeInfo"]["imageLinks"].nil? ? book[:thumbnail] = ActionController::Base.helpers.asset_path("dummybook.png") : book[:thumbnail] = element["volumeInfo"]["imageLinks"]["smallThumbnail"]

      books_list.push(book)

      # puts "Nome do autor: #{element["volumeInfo"]["authors"].first} "
      # puts "Editora: #{element["volumeInfo"]["publisher"]}"
      # puts "Ano de lançamento: #{element["volumeInfo"]["publishedDate"]}"
      # puts "Thumbnail: #{element["volumeInfo"]["imageLinks"]["smallThumbnail"]}"
      # puts "#####################################################"
    end

    return books_list

  end

end
