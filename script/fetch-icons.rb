require 'fileutils'
require 'rubygems'
require 'nokogiri'

root = File.dirname(__FILE__) + "/.."

YAML.load_file(root + "/data/days.yml").each do |_, gift|
  img_filename = root + "/public" + gift['icon']
  next if File.exist?(img_filename)
  
  xml = `curl -s -H "X-Apple-Store-Front: 143441-1,5" "#{gift["url"]}"`
  img_url = Nokogiri::XML(xml).at_css("img.artwork")['src']
  FileUtils.mkdir_p(File.dirname(img_filename))
  system("curl -s -o #{img_filename} #{img_url}")
end
