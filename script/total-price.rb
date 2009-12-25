require 'rubygems'
require 'nokogiri'

root = File.dirname(__FILE__) + "/.."

total_price = 0.0

YAML.load_file(root + "/data/days.yml").each do |_, gift|
  xml = `curl -s -H "X-Apple-Store-Front: 143441-1,5" "#{gift["url"]}"`
  price = Nokogiri::XML(xml).at_css("span.price").content.gsub('$', '').to_f
  puts "#{gift['name']}: $#{price.inspect}"
  total_price += price
end

puts "Total price: $#{total_price}"
