require_relative 'find_by'
require_relative 'errors'
require 'csv'

class Udacidata
  DB = File.dirname(__FILE__) + "/../data/data.csv"

  class << self
    def create(options = {})
      product = Product.new(options)
      add(product) unless options[:id]
      product
    end

    def all
      products = CSV.read(DB, headers: true) || []
      products.map  {|p| Product.create(id: p[0], brand: p[1], name: p[2], price: p[3])} || []
    end

    def first(n=nil)
      take_items(:first, n)
    end

    def last(n=nil)
      take_items(:last, n)
    end

    def find(id)
      find_by(id: id)
    end
    create_finder_methods(:price, :brand, :name)

    def where(options = {})
      find_by(options.merge({where: true}))
    end

    def update(options = {})
      destroy(options[:id])
      product = Product.new(options)
      add(product)
      product
    end

    def destroy(id)
      product = find(id)
      remove(id)
      product
    end

    private

    def add(*products)
      products.flatten.each do |product|
        CSV.open(DB, 'a+') { |csv| csv << [product.id, product.brand, product.name, product.price] }
      end
    end

    def find_by(options={})
      result = all
      if options[:where]
        options.delete(:where)
        options.each { |attribute, value|
          result = result.select {|p| p.public_send(attribute.to_sym) == value}
        }
      else
        result = all.each {|p| return p if p.public_send(options.first[0]) == options.first[1]}
      end
      result
    end

    def take_items(from, n=nil)
      n ? all.send(from, n) : all.send(from)
    end

    def remove(id)
      product = all.reject {|item| item.id == id}
      prepare_file
      add(product)
    end

    def prepare_file(headers = false)
      if headers
        CSV.open(DB, 'w+') { |csv| csv << '' }
      else
        CSV.open(DB, 'w+') { |csv| csv.add_row ["id", "brand", "product", "price"] }
      end
    end
  end

end
