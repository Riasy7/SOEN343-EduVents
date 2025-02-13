require 'rails_helper'

RSpec.describe AttendeeUser, type: :model do
  context "when creating a attendee user" do
    it "successfully creates a speaker attendee" do
      speaker = create(:attendee_speaker_user)
      expect(speaker).to be_valid
    end

    it "successfully creates a listener attendee" do
      listener = create(:attendee_listener_user)
      expect(listener).to be_valid
    end
  end
end
