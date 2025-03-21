# Delete all objects to reset the db
AdminUser.delete_all
ExecutiveUser.delete_all
OrganizerUser.delete_all
AttendeeUser.delete_all
Location.delete_all
Organization.delete_all

# Repopulate the db
AdminUser.create!(username: "admin", password: "password", email: "admin@edu-events.ca", first_name: "John", last_name: "Doe")
ExecutiveUser.create!(username: "executive", password: "password", email: "executive@edu-events.ca", first_name: "Jane", last_name: "Smith")
OrganizerUser.create!(username: "organizer", password: "password", email: "organizer@edu-events.ca", first_name: "George", last_name: "Staples")
AttendeeUser.create!(username: "speaker", password: "password", email: "speaker@edu-events.ca", first_name: "Marc", last_name: "Williams", attendee_type: "speaker")
AttendeeUser.create!(username: "listener", password: "password", email: "listener@edu-events.ca", first_name: "Sarah", last_name: "Hull", attendee_type: "listener")

# I have to nest the location inside the organization cause the location model has a belongs_to association with the organization model
# however i can change the model validations itself but i did this instead
Organization.create!(
  name: "Concordia University",
  website: "https://www.concordia.ca",
  phone: "+5141234567",
  locations_attributes: [
    { name: "SGW Campus", address1: "1455 De Maisonneuve Blvd. W.", city: "Montreal", state: "QC", country: "CANADA", postal_code: "H3G 1M8" },
    { name: "Loyola Campus", address1: "7141 Sherbrooke St. W.", city: "Montreal", state: "QC", country: "CANADA", postal_code: "H4B 1R6" }
  ]
)