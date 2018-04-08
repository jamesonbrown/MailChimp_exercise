require 'selenium-webdriver'
require 'csv'

# This class serves as the data model for team members on the About page
class TeamMember

	attr_reader :name, :position, :description

	def initialize(name, position, description)
		@name = name
		@position = position
		@description = description
	end

end

class AboutPageTest 

	def run_test
		setup
		navigate_to_home_page
		navigate_to_about_page
		get_team_info
		teardown
	end

	def setup
		#Initialize the driver
		@driver = Selenium::WebDriver.for :firefox
	end

	def navigate_to_home_page
		#Go to mailchimp.com
		puts "Launching home page..."
		@driver.navigate.to 'https://www.mailchimp.com'
	end

	def navigate_to_about_page
		#Finds and clicks the About page link in the footer
		puts "Navigating to about page..."
		about_page_link = @driver.find_element(:xpath => "//a[@href = '/about']")
		about_page_link.click
	end

	def get_team_info
		#Initialize an array for team member data 
		team_members = []

		#Find each team member bio on About page
		bios = @driver.find_elements(class: 'bio_link')
		puts "Reading team data..."

		#Create a TeamMember instance from each bio, map data, and add to team_members array
		bios.each do |bio|
			name = bio.attribute('data-title')
			position = bio.attribute('data-position')
			description = bio.attribute('data-description')
			member = TeamMember.new(name, position, description)
			team_members.push(member)
		end

		#Writes a .csv file with team member data
		CSV.open("leadership_team.csv", "wb") do |csv|
	  		csv << ["Name", "Position", "Description"]
	  		team_members.each do |member|
	  			csv << [member.name, member.position, member.description]
	  		end
	  	end
	  	puts "Finished writing file."
	end

	def teardown
		@driver.quit
	end

end