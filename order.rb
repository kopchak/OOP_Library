class Order
  attr_accessor :book, :reader, :date

  def initialize(book, reader)
    @book, @reader, @date = book, reader, Time.now.strftime("%H:%M:%S %d-%m-%Y")
  end
end