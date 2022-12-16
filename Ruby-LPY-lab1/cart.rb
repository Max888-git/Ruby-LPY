require_relative './lib/item_container'
require 'csv'
require 'nokogiri'
require 'json'

class Cart
    def initialize(items)
        @items = items
    end

    def write_file(filename, content)
        File.open(filename, 'w') { |file| file.write(content) }
    end

    def get_all_files_recursively(root_directory, permitted_extensions)
        files = Dir.glob("#{root_directory}/**/*").select { |e| File.file? e }

        files.select { |f| permitted_extensions.any? { |ext| ext == File.extname(f)} }
    end

    def save_to_csv()
        CSV.open("file.csv", "wb") do |csv|
            page.css('.item').each do |items|
              name = item.at_css('a').text
              link = item.at_css('a')[:href]
              csv << [name, link]
    end

    def save_to_json()
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