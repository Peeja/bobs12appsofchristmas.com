require 'fileutils'
require 'rubygems'
require 'nokogiri'

YAML.load_file("data/days.yml").map do |_, gift|
  img_filename = File.dirname(__FILE__) + "/public" + gift['icon']
  next if File.exist?(img_filename)
  
  xml = `curl -s -H "X-Apple-Store-Front: 143441-1,5" "#{gift["url"]}"`
  img_url = Nokogiri::XML(xml).css("img.artwork").first['src']
  FileUtils.mkdir_p(File.dirname(img_filename))
  system("curl -s -o #{img_filename} #{img_url}")
end
