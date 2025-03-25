FactoryBot.define do
  factory :user do
    first_name { "John" }
    last_name { "Doe" }
    username { Faker::Internet.unique.username }
    email { Faker::Internet.unique.email }
    password { "password" }
    password_confirmation { "password" }

    factory :attendee_speaker_user do
      attendee_type { "speaker" }
      username { "speaker" }
      email { "speaker@edu-events.ca" }
    end

    factory :attendee_listener_user, class: "AttendeeUser" do
      attendee_type { "listener" }
      username { Faker::Internet.unique.username }
      email { Faker::Internet.unique.email }
      password { "password" }
      password_confirmation { "password" }
    end

    factory :organizer do
      username { "organizer" }
      email { "organizer@edu-events.ca" }
    end
  end
end
