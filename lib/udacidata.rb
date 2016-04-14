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

  def self.add_products(products = [])
    products.each{|product| add_product(product) }
  end

  def self.products
    products = CSV.read(DATA_FILE).drop(1) || []
    products.map  {|p| Product.create(id: p[0], brand: p[1], name: p[2], price: p[3])} || []
  end

  def self.clear_products(headers = false)
    if headers
      CSV.open(DATA_FILE, 'w+') { |csv| csv << '' }
    else
      CSV.open(DATA_FILE, 'w+') { |csv| csv.add_row ["id", "brand", "product", "price"] }
    end
  end

  def self.remove_product(id)
    prods = products.reject {|item| item.id == id}
    clear_products
    add_products(prods)
  end
end
