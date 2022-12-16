require 'rubygems'
require 'mechanize'

class Parser
    def parse_catalogue_page(catalogue_link)
        agent = Mechanize.new
        page = agent.get(catalogue_link)
        product_links = page.links_with(:href => %r{products/}, :class => "h3" )

        product_links.map { |l| "#{page.uri.scheme}://#{page.uri.host}/#{l.uri}" }
    end

    def parse_product_page(product_link)
        agent = Mechanize.new
        page = agent.get(product_link)
        
        author_name = page.search("//div[@class='author_title']").text
        book_name = page.search("//div[@class='product']//h1").text
        publisher = page.search("//tr[@class='params product-features_params'][2]/td[@class='value']/span[@class='fn-feature_wrap']/a").text
        price_in_uah = page.search("//span[@id='tabsPaper']/span[@class='tab-price']").text
        product_image_url = page.search("//a[@class='gallery']/@href").text

        Item.new(book_name, author_name, price_in_uah, publisher, product_image_url)
    end
end