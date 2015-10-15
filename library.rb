require "yaml"
require_relative "book.rb"
require_relative "order.rb"
require_relative "reader.rb"
require_relative "author.rb"

class Library
  attr_accessor :books, :orders, :readers, :authors

  def initialize file
    @books, @orders, @readers, @authors = [], [], [], []
    get_data file
  end

  def add_book book
    @books << book
  end

  def add_order order
    @orders << order
  end

  def add_reader reader
    @readers << reader
  end

  def add_author author
    @authors << author
  end

  def active_reader
    hash = @orders.inject(Hash.new(0)) do |count, order|
      count[order.reader.name] += 1
      count
    end
    top_reader = hash.max_by { |key, value| value }.first
    puts "\nMost active reader: #{top_reader}"
  end

  def popular_book
    hash_with_books_count
    top_book = @hash.max_by { |key, value| value }.first
    puts "Most popular book: #{top_book}"
    puts "\n"
  end

  def readers_one_of_the_three_most_popular_books
    books = {}
    hash_with_books_count
    @hash.max_by { |key, value| books[key] = value }
    3.times { |i| puts "#{i+1}. Popular book: #{books.keys[i]}, have #{books.values[i]} reader(s);"}
    puts "\n"
  end

  def save_data file
    File.open(file, "w") { |file| file.puts(self.to_yaml) }
  end

  private
    def hash_with_books_count
      @hash = @orders.inject(Hash.new(0)) do |count, order|
        count[order.book.title] += 1 
        count
      end
    end

    def get_data file
      @read =  File.open(file) { |f| YAML::load( f ) }
      @books = @read.books
      @orders = @read.orders
      @readers = @read.readers
      @authors = @read.authors
    end
end

library = Library.new('database.yaml')

# author1 = Author.new("name1", "biography1")
# author2 = Author.new("name2", "biography2")
# author3 = Author.new("name3", "biography3")
# author4 = Author.new("name4", "biography4")

# book1   = Book.new("book1", author1)
# book2   = Book.new("book2", author2)
# book3   = Book.new("book3", author3)
# book4   = Book.new("book4", author4)

# reader1 = Reader.new("reader1", "reader1@reader.ua", "dnepr",    "reader1street", "2")
# reader2 = Reader.new("reader2", "reader2@reader.ua", "dnepr",    "reader2street", "1")
# reader3 = Reader.new("reader3", "reader3@reader.ua", "kiev",     "reader3street", "37")
# reader4 = Reader.new("reader4", "reader4@reader.ua", "cherkasy", "reader4street", "17")

# order1  = Order.new(book1, reader1)
# order2  = Order.new(book1, reader1)
# order3  = Order.new(book1, reader1)
# order4  = Order.new(book2, reader2)
# order5  = Order.new(book2, reader2)
# order6  = Order.new(book3, reader3)
# order7  = Order.new(book4, reader4)

# library.add_author(author1)
# library.add_author(author2)
# library.add_author(author3)
# library.add_author(author4)

# library.add_book(book1)
# library.add_book(book2)
# library.add_book(book3)
# library.add_book(book4)

# library.add_reader(reader1)
# library.add_reader(reader2)
# library.add_reader(reader3)
# library.add_reader(reader4)

# library.add_order(order1)
# library.add_order(order2)
# library.add_order(order3)
# library.add_order(order4)
# library.add_order(order5)
# library.add_order(order6)
# library.add_order(order7)

library.active_reader
library.popular_book
library.readers_one_of_the_three_most_popular_books
#library.save_data('database.yaml')