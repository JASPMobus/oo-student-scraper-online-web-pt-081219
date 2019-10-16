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
    socials = Nokogiri::HTML(open(profile_url)).css("div.social-icon-container a")
    
    socials = socials.map { |social| social["href"] }
    
    if socials
      twitter = socials.find { |social| social.include?("twitter") }
      socials = socials.delete(twitter)
    else 
      twitter = nil
    end

    if socials
      linkedin = socials.find { |social| social.include?("linkedin") }
      socials = socials.delete(linkedin)
    else
      linkedin = nil
    end

    if socials
      github = socials.find { |social| social.include?("github") }
      socials = socials.delete(github)
    else
      github = nil 
    end

    if socials
    blog = socials.first
    
    quote = Nokogiri::HTML(open(profile_url)).css("div.profile-quote")
    bio = Nokogiri::HTML(open(profile_url)).css("div.description-holder p")
    
    {
      :twitter => twitter,
      :linkedin => linkedin,
      :github => github,
      :blog => blog,
      :profile_quote => quote.text, 
      :bio => bio.text
    }
  end 

end 

