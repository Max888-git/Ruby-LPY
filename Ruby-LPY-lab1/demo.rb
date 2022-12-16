require_relative 'item'
require_relative 'cart'
require_relative './lib/file_helper'

engine = Engine.new("https://nashformat.ua/catalog/politolohiia", EmailCredentials.get_email_credentials, "ghosteagle07@gmail.com")
products = engine.perform_parsing(1)
cart = Cart.new(products)

file_helper = FileHelper.new
file_helper.write_file('products.csv', cart.save_to_csv)
file_helper.write_file('products.json', cart.save_to_json)
