require 'sinatra'
require 'haml'
require 'active_support'
require 'linguistics'

configure do
  Linguistics.use(:en, :installProxy => :en)
end


get '/' do
  day_of_christmas = 12
  gifts = YAML.load_file("data/days.yml").sort_by(&:first).reverse.select { |day, _| day <= day_of_christmas }.map(&:last)
  
  # "and" hack
  gifts.last["lyric"] = "and " + gifts.last["lyric"] if gifts.size > 1
  
  haml :index, :locals => { :gifts => gifts, :day_of_christmas => day_of_christmas }
end
