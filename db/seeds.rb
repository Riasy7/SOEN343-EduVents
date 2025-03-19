# Delete all objects to reset the db
AdminUser.delete_all
ExecutiveUser.delete_all
OrganizerUser.delete_all
AttendeeUser.delete_all

# Repopulate the db
AdminUser.create!(username: "admin", password: "password", email: "admin@edu-events.ca", first_name: "John", last_name: "Doe")
ExecutiveUser.create!(username: "executive", password: "password", email: "executive@edu-events.ca", first_name: "Jane", last_name: "Smith")
OrganizerUser.create!(username: "organizer", password: "password", email: "organizer@edu-events.ca", first_name: "George", last_name: "Staples")
AttendeeUser.create!(username: "speaker", password: "password", email: "speaker@edu-events.ca", first_name: "Marc", last_name: "Williams", attendee_type: "speaker")
AttendeeUser.create!(username: "listener", password: "password", email: "listener@edu-events.ca", first_name: "Sarah", last_name: "Hull", attendee_type: "listener")
Organization.create!(name: "Concordia University", website: "https://www.concordia.ca", phone: "+5141234567")