gem 'nokogiri'
require 'nokogiri'

require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    students = Nokogiri::HTML(open(index_url)).css("div.student-card a")
  end

  def self.scrape_profile_page(profile_url)
    
  end

end

