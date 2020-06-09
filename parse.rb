require 'json'

# file = File.read('/Users/nicolewang/ruby-project-guidelines-yale-web-yss-052520/yelp_academic_dataset_business.json')
# hash = JSON.parse(file)

def loadfile(filepath = '/Users/nicolewang/ruby-project-guidelines-yale-web-yss-052520/yelp_academic_dataset_business.json')
    file = File.read("filepath")
    data = JSON.parse(file)
end

def location
    loadfile.map{|k|k["postal_code"]}.uniq
end 