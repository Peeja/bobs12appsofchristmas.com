require 'rubygems'
require 'activesupport'


root = File.dirname(__FILE__) + "/.."

gifts = YAML.load_file(root + "/data/days.yml").sort_by(&:first).map(&:last)
keys = gifts.map(&:keys).flatten.uniq

gifts.each do |gift|
  missing_keys = keys - gift.keys
  puts "#{gift['name']} is missing #{missing_keys.to_sentence}" if missing_keys.any?
end
