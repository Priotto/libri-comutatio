class Books < ApplicationService
  attr_accessor :_title, :_author

  def initialize(_title, _author)
    @title = _title
    @author = _author
    @key = ENV["BOOKS_API"]
  end

  def call
    unless @key.nil?
      if @title.empty?
        url = "https://www.googleapis.com/books/v1/volumes?q=+inauthor:#{@author}&key=#{@key}"
      else
        url = "https://www.googleapis.com/books/v1/volumes?q=+intitle:#{@title}&key=#{@key}"
      end
      uri = URI(url)
      fetch = Net::HTTP.get(uri)
      JSON.parse(fetch)
    end
  end

  def digest(response)
    books_list = []
    response["items"].each do |element|
      book = Hash.new

      book[:title] = element["volumeInfo"]["title"]
      book[:author] = element["volumeInfo"]["author"].first
      book[:publisher] = element["volumeInfo"]["publisher"]
      book[:published_date] = element["volumeInfo"]["publishedDate"]
      book[:thumbnail] = element["volumeInfo"]["imageLinks"]["smallThumbnail"]

      book_list.push(book)

      # puts "Nome do autor: #{element["volumeInfo"]["authors"].first} "
      # puts "Editora: #{element["volumeInfo"]["publisher"]}"
      # puts "Ano de lançamento: #{element["volumeInfo"]["publishedDate"]}"
      # puts "Thumbnail: #{element["volumeInfo"]["imageLinks"]["smallThumbnail"]}"
      # puts "#####################################################"
    end

    return book_list

  end

end
