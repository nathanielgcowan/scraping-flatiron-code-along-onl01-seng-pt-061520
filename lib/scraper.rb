require 'nokogiri'
require 'open-uri'

require_relative './course.rb'

class Scraper

  def get_page
    Nokogiri::HTML(open("http://austinswingsyndicate.org/"))
  end

  def get_courses
    self.get_page.css("div.slide-content")
  end

  def make_courses
    self.get_courses.each do |thing|
      course = Course.new
      course.title = thing.css("h3").text
      course.schedule = thing.css("time.slide-meta-time updated").text
      course.description = thing.css("div.slide-entry-excerpt entry-content").text.strip
    end
  end

  def print_courses
    self.make_courses
    Course.all.each do |course|
      if course.title && course.title != ""
        puts "Title: #{course.title}"
        puts "  Schedule: #{course.schedule}"
        puts "  Description: #{course.description}"
      end
    end
  end

end