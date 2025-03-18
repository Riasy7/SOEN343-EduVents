# Delete all objects to reset the db
AdminUser.delete_all
ExecutiveUser.delete_all
OrganizerUser.delete_all
AttendeeUser.delete_all

# Repopulate the db
AdminUser.create!(username: "admin", password: "password", email: "admin@edu-events.ca", first_name: "John", last_name: "Doe", type: "AdminUser")
ExecutiveUser.create!(username: "executive", password: "password", email: "executive@edu-events.ca", first_name: "Jane", last_name: "Smith", type: "ExecutiveUser")
OrganizerUser.create!(username: "organizer", password: "password", email: "organizer@edu-events.ca", first_name: "George", last_name: "Staples", type: "OrganizerUser")
AttendeeUser.create!(username: "speaker", password: "password", email: "speaker@edu-events.ca", first_name: "Marc", last_name: "Williams", type: "AttendeeUser", attendee_type: "speaker")
AttendeeUser.create!(username: "listener", password: "password", email: "listener@edu-events.ca", first_name: "Sarah", last_name: "Hull", type: "AttendeeUser", attendee_type: "listener")
