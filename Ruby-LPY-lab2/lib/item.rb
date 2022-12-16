class Item
    attr_accessor :book_name, :author_name, :price_in_uah, :publisher, :image_url

    def initialize(book_name, author_name, price_in_uah, publisher, image_url)
        @book_name = book_name
        @author_name = author_name
        @price_in_uah = price_in_uah
        @publisher = publisher
        @image_url = image_url
    end

    def info(block)
        @info = block
    end

    def to_s
        "#{@author_name} #{@book_name} #{@price_in_uah}" 
    end

    def to_h        
    end
end

