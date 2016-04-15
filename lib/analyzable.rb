module Analyzable
  def average_price(products)
    (products.inject(0){|sum, product| sum + product.price.to_f}/products.size).round(2)
  end

  def print_report(products)
    report_text = "Average Price: $#{average_price(products)}\n"
    report_text << "Inventory by Brand:\n"
    count_by_brand(products).each{|key, value| report_text << "  - #{key}: #{value}\n"}
    report_text << "Inventory by Name:\n"
    count_by_name(products).each{|key, value| report_text << "  - #{key}: #{value}\n"}
    report_text
  end

  [:name, :brand].each do |meth|
    define_method("count_by_#{meth}") do |products|
      result = {}
      items = products.map {|product|product.send(meth.to_sym)}
      items.uniq.each{|item| result[item] = items.count(item)}
      result
    end
  end
end
