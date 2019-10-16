gem 'nokogiri'
require 'nokogiri'

require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    ret_array = []
    
    students = Nokogiri::HTML(open(index_url)).css("div.student-card a")
    
    students.each do |student|
      student_hash = {
        :name => student["div.card-text-container h4"].text,
        :location => student["div.card-text-container p"].text
        :profile_url => student["href"]
      }
      
      ret_array.push(student_hash)
    end 
    
    ret_array
      
  end

  def self.scrape_profile_page(profile_url)
    
  end

end

