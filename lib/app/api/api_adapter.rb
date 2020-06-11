require 'pry'
require "json"
require "http"
require "optparse"
require 'pry'

class ApiAdapter 

  # Place holders for Yelp Fusion's API key. Grab it
  # from https://www.yelp.com/developers/v3/manage_app
  API_KEY = "Z-gQ7C9JfG_sGRoZ8xHHt5yjXflqYi5OnZANwY6SuiEz_479MJ8HC9mYlN5_D1FijWM59DWRfo-mp3p3XUaVgsnvPnU0wP7K2U7h_Lh3LnXMlB1rLTrkHLOy5c3eXnYx"


  # Constants, do not change these
  API_HOST = "https://api.yelp.com"
  SEARCH_PATH = "/v3/businesses/search"
  BUSINESS_PATH = "/v3/businesses/"
  SEARCH_LIMIT = 10

  def self.search(term, location, sort_by = "best_match")
    url = "#{API_HOST}#{SEARCH_PATH}"
    params = {
      term: term,
      location: location,
      sort_by: sort_by,
      limit: SEARCH_LIMIT
    }
  response = HTTP.auth("Bearer #{API_KEY}").get(url, params: params)
  response.parse
  end


  def self.business(business_id)
    url = "#{API_HOST}#{BUSINESS_PATH}#{business_id}"

    def self.names(term, location)
      self.search(term, location)["businesses"].map {|business| business["name"]} 
    end 
    
    def self.ids(term, location)
      self.search(term, location)["businesses"].map {|business| business["id"]} 
    end 
    
    def self.addresses(term, location)
      self.search(term, location)["businesses"].map {|business| business["location"]["display_address"].join(" ")}
    end 
    
    def self.prices(term, location)
      self.search(term, location)["businesses"].map {|business| business["price"]}
    end 
    
    def self.ratings(term, location)
      self.search(term, location)["businesses"].map {|business| business["rating"]}
    end 
    

    options = {}
    OptionParser.new do |opts|
      opts.banner = "Example usage: ruby sample.rb (search|lookup) [options]"

      opts.on("-tTERM", "--term=TERM", "Search term (for search)") do |term|
        options[:term] = term
      end

      opts.on("-lLOCATION", "--location=LOCATION", "Search location (for search)") do |location|
        options[:location] = location
      end

      opts.on("-PRICE", "--price=PRICE", "Search price (for search)") do |price|
        options[:price] = price
      end

      opts.on("-sSORT_BY", "--sort_by=SORT_BY", "Search sort_by (for search)") do |sort_by|
        options[:sort_by] = sort_by
      end

      opts.on("-bBUSINESS_ID", "--business-id=BUSINESS_ID", "Business id (for lookup)") do |id|
        options[:business_id] = id
      end

      opts.on("-h", "--help", "Prints this help") do
        puts opts
        exit
      end
    end.parse!
  end

end





# binding.pry
# 0