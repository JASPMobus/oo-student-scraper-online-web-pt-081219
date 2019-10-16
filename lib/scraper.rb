gem 'nokogiri'
require 'nokogiri'

require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    ret_array = []
    
    students = Nokogiri::Slop(open(index_url)).css("div.student-card a")
    
    students.each do |student|
      student_hash = {
        :name => student.div[1].h4.text,
        :location => student.div[1].p.text,
        :profile_url => student["href"]
      } 
      
      ret_array.push(student_hash) 
    end  
    
    ret_array 
  end 

  def self.scrape_profile_page(profile_url) 
    info = Nokogiri::Slop(open(profile_url))
    {
      :twitter => info.html.body.div.div[1]., 
      :linkedin => nil, 
      :github => nil, 
      :blog => nil, 
      :profile_quote => nil, 
      :bio => nil
    }
  end 

end 

