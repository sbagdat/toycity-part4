require_relative 'find_by'
require_relative 'errors'
require 'csv'

class Udacidata

  # Your code goes here!
  def self.add_product(product)
    file = File.dirname(__FILE__) + "/../data/data.csv"
    CSV.open(file, 'a+') { |csv| csv << [product.id, product.brand, product.name, product.price] }
  end
end
