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
    
    socials = socials.map { |social| social["href"] }
    
    twitter = socials.find { |social| social.include?("twitter") }
    socials = socials.delete(twitter)
    linkedin = socials.find { |social| social.include?("linkedin") }
    socials = socials.delete(linkedin)
    github = socials.find { |social| social.include?("github") }
    socials = socials.delete(github)
    blog = socials.first
    quote = Nokogiri::HTML(open(profile_url)).css("div.profile-quote")
    bio = Nokogiri::HTML(open(profile_url)).css("div.description-holder p")
    
    {
      :twitter => ,
      :linkedin => socials.find { |social| social.include?("linkedin") },
      :github => socials.find { |social| social.include?("github") },
      :blog => socials.delete,
      :profile_quote => quote.text, 
      :bio => bio.text
    }
  end 

end 

