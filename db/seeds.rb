# Delete all objects to reset the db
EventRegistration.delete_all
Event.delete_all
AdminUser.delete_all
ExecutiveUser.delete_all
OrganizerUser.delete_all
AttendeeUser.delete_all
Venue.delete_all
Location.delete_all
Organization.delete_all

# Repopulate the db
AdminUser.create!(username: "admin", password: "password", email: "admin@edu-events.ca", first_name: "John", last_name: "Doe")
ExecutiveUser.create!(username: "executive", password: "password", email: "executive@edu-events.ca", first_name: "Jane", last_name: "Smith")
organizer = OrganizerUser.create!(username: "organizer", password: "password", email: "organizer@edu-events.ca", first_name: "George", last_name: "Staples")
speaker = AttendeeUser.create!(username: "speaker", password: "password", email: "speaker@edu-events.ca", first_name: "Marc", last_name: "Williams", attendee_type: "speaker")
listener = AttendeeUser.create!(username: "listener", password: "password", email: "listener@edu-events.ca", first_name: "Sarah", last_name: "Hull", attendee_type: "listener")

# I removed the organization validation that checks for the presence of at least one location when creating it because
# there was too many issues when creating specs for organizations, locations, venues, etc.
# Instead, we'll just create an organization first, and then we'll associate them with locations, like we are doing here.
organization = Organization.create!(name: "Concordia University", website: "https://www.concordia.ca", phone: "+5141234567")
location = Location.create!(name: "SGW Campus", address1: "1455 De Maisonneuve Blvd. W.", address2: "Suite 203", city: "Montreal", state: "QC", country: "CANADA", postal_code: "H3G 1M8", organization_id: organization.id)
venue = Venue.create!(name: "H - Sir George Williams University Alumni Auditorium (H-110)", max_capacity: 692, price_per_seat: 0.0, location_id: location.id)
events = [
  { name: "Tech Innovators Summit", event_type: "conference" },
  { name: "AI & Machine Learning Workshop", event_type: "workshop" },
  { name: "Cybersecurity Seminar", event_type: "seminar" },
  { name: "Hackathon 2025", event_type: "competition" },
  { name: "Entrepreneurship Bootcamp", event_type: "workshop" },
  { name: "Future of Web Development", event_type: "conference" },
  { name: "Startup Pitch Battle", event_type: "competition" },
  { name: "Leadership & Growth Seminar", event_type: "seminar" },
  { name: "Cloud Computing Masterclass", event_type: "workshop" },
  { name: "Game Development Jam", event_type: "competition" },
  { name: "AI Ethics & Policy Panel", event_type: "seminar" },
  { name: "Coding Bootcamp Challenge", event_type: "competition" },
  { name: "Product Management Insights", event_type: "seminar" }
]

events.each do |event_data|
  event = Event.create!(name: event_data[:name], event_type: event_data[:event_type], organizer_id: organizer.id, venue_id: venue.id)
  EventRegistration.create!(event_id: event.id, attendee_id: listener.id, role: "listener") if rand(2) == 1
  EventRegistration.create!(event_id: event.id, attendee_id: speaker.id, role: "speaker") if rand(2) == 1
end
