require_relative 'find_by'
require_relative 'errors'
require 'csv'

class Udacidata
  DATA_FILE = File.dirname(__FILE__) + "/../data/data.csv"
  # Your code goes here!
  def self.add_product(product)
    CSV.open(DATA_FILE, 'a+') { |csv| csv << [product.id, product.brand, product.name, product.price] }
    product
  end

  def self.products
    products = CSV.read(DATA_FILE).drop(1) || []
    products.map{|p| Product.create(id: p[0], brand: p[1], name: p[2], price: p[3])}
  end
end
