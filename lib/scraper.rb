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
    socials = Nokogiri::Slop(open(profile_url)).css("div.social-icon-container a")
    quote = Nokogiri::HTML(open(profile_url)).css("div.profile-quote")
    bio = Nokogiri::HTML(open(profile_url)).css("div.description-holder p")
    
    {
      skips = 0
      :twitter => 
        begin 
          socials[0]["href"]
        rescue NoMethodError
          skips += 1
          nil
        end,
      :linkedin => 
        begin 
          socials[1 - skips]["href"]
        rescue NoMethodError
          skips += 1
          nil
        end,
      :github => 
        begin 
          socials[2 - skips]["href"]
        rescue NoMethodError
          skips += 1
          nil
        end,
        begin 
          :blog => socials[3 - skips]["href"]
        rescue NoMethodError
          skips += 1
          :blog => nil
        end,
      :profile_quote => quote.text, 
      :bio => bio.text
    }
  end 

end 

