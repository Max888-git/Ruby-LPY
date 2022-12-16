require_relative './infrastructure/parser'
require_relative './cart'
require_relative './item'
require_relative './infrastructure/zipper'
require_relative './infrastructure/file_helper'

class Engine
    def initialize(web_address, email_credentials, email_to_send)
        @web_address = web_address
        @email_credentials = email_credentials
        @email_to_send = email_to_send

        @number_of_threads_to_use = 3
    end 

    def perform_parsing(number_of_pages)
        parser = Parser.new

        pages = (1..number_of_pages).to_a.map { |i| "#{@web_address}-#{i}" }
        
        
        product_links = []
        pages.each do |page|
            product_links += parser.parse_catalogue_page(page)
        end

        parsed_products = []
        product_links.each_slice(@number_of_threads_to_use).each do |links_batch|
            threads = []

            links_batch.each do |link| 
                threads << Thread.new { parser.parse_product_page(link) }
            end

            parsed_products += threads.map(&:value)
        end

        parsed_products

        cart = Cart.new parsed_products
        file_helper = FileHelper.new

        random_suffix = DateTime.now.strftime("%N")

        file_helper.write_file("products-#{random_suffix}.csv", cart.to_csv)
        zipper = Zipper.new("./", "application-#{random_suffix}.zip", [".rb", ".csv"])
        zipper.write


    end
end