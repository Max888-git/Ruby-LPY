require 'yaml'
require 'csv'

class Cart
    def initialize(items)
        @items = items
    end

    def to_yml
        self.to_yaml
    end

    def to_csv()
        csv_string = CSV.generate do |csv|
            @items.each do |item|
                csv << [item.book_name, item.author_name, item.price_in_uah, item.publisher, item.image_url]
            end
        end

        csv_string
    end
end
