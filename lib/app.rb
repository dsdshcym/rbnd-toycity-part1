require 'json'
path = File.join(File.dirname(__FILE__), '../data/products.json')
file = File.read(path)
products_hash = JSON.parse(file)

require 'date'

# Print today's date
def puts_todays_date
  puts "Today's Date: #{Date.today}"
end
puts_todays_date

puts "                     _            _       "
puts "                    | |          | |      "
puts " _ __  _ __ ___   __| |_   _  ___| |_ ___ "
puts "| '_ \\| '__/ _ \\ / _` | | | |/ __| __/ __|"
puts "| |_) | | | (_) | (_| | |_| | (__| |_\\__ \\"
puts "| .__/|_|  \\___/ \\__,_|\\__,_|\\___|\\__|___/"
puts "| |                                       "
puts "|_|                                       "


# For each product in the data set:
  # Print the name of the toy
  # Print the retail price of the toy
  # Calculate and print the total number of purchases
  # Calculate and print the total amount of sales
  # Calculate and print the average price the toy sold for
  # Calculate and print the average discount (% or $) based off the average sales price

def puts_divider
  puts "********************"
end

brands = Hash.new { |h, k| h[k] = Array.new }

products_hash["items"].each_with_index do |toy, i|
  puts_divider if i > 0
  puts
  puts toy["title"]
  puts_divider

  brands[toy["brand"]] << toy

  retail_price = toy["full-price"].to_f
  puts "Retail Price: $#{retail_price}"

  total_purchases = toy["purchases"].count
  puts "Total Purchases: #{total_purchases}"

  total_sum = toy["purchases"].map { |purchase| purchase["price"].to_f }.inject(&:+)
  puts "Total Sales: $#{total_sum}"

  average_price = total_sum / total_purchases
  puts "Average Price: $#{average_price}"

  average_discount = retail_price - average_price
  puts "Average Discount: $#{average_discount}"

  average_discount_percentage = (average_discount / retail_price * 100).round(2)
  puts "Average Discount Percentage: #{average_discount_percentage}%"
end

puts

	puts " _                         _     "
	puts "| |                       | |    "
	puts "| |__  _ __ __ _ _ __   __| |___ "
	puts "| '_ \\| '__/ _` | '_ \\ / _` / __|"
	puts "| |_) | | | (_| | | | | (_| \\__ \\"
	puts "|_.__/|_|  \\__,_|_| |_|\\__,_|___/"
	puts

# For each brand in the data set:
  # Print the name of the brand
  # Count and print the number of the brand's toys we stock
  # Calculate and print the average price of the brand's toys
  # Calculate and print the total revenue of all the brand's toy sales combined

brands.each_pair.with_index do |(brand, products), i|
  puts if i > 0
  puts brand
  puts_divider

  number_of_products = products.inject(0) { |num, product| num + product["stock"] }
  puts "Number of Products: #{number_of_products}"

  average_product_price = (products.inject(0) do |total_price, product|
    total_price + product["full-price"].to_f
  end / products.length).round(2)
  puts "Average Product Price: $#{average_product_price}"

  total_sales = products.inject(0) do |total_sales, product|
    total_sales + product["purchases"].inject(0) { |sales, purchase| sales + purchase["price"].to_f }
  end.round(2)
  puts "Total Sales: $#{total_sales}"
end
