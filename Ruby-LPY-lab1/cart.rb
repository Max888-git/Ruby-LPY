require_relative './lib/item_container'
require_relative './item'
require 'csv'
require 'json'

class Cart
    def initialize(items)
        @items = items
    end

    def save_to_csv()
        csv_string = CSV.generate do |csv|
            @items.each do |item|
                csv << [item.book_name, item.author_name, item.price_in_uah, item.publisher, item.image_url]
            end
        end

        csv_string
    end

    def save_to_json()
        self.to_json
    end

    def save_to_file(filetype)
        case 
        when filetype == 'csv'
            save_to_csv()
        when filetype == 'json'
            save_to_json()
        else
            raise SomeException, 'Error: No filetype'   
        end
    end
end