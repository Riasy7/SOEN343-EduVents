require 'rails_helper'

RSpec.describe Venue, type: :model do
  context "when creating a venue" do
    before(:each) do
      @venue = create(:venue)
    end

    it "successfully creates a venue" do
      expect(@venue).to be_valid
    end

    it "is invalid without a name" do
      venue_without_name = build(:venue, name: nil)
      expect(venue_without_name).not_to be_valid
    end

    it "is invalid without a max capacity" do
      venue_without_max_capacity = build(:venue, max_capacity: nil)
      expect(venue_without_max_capacity).not_to be_valid
    end

    it "is invalid with a max capacity smaller than 1" do
      venue_with_invalid_max_capacity = build(:venue, max_capacity: 0)
      expect(venue_with_invalid_max_capacity).not_to be_valid
    end

    it "is invalid without a price per seat" do
      venue_without_price_per_seat = build(:venue, price_per_seat: nil)
      expect(venue_without_price_per_seat).not_to be_valid
    end

    it "is invalid with a negative price per seat" do
      venue_with_negative_price_per_seat = build(:venue, price_per_seat: -10.0)
      expect(venue_with_negative_price_per_seat).not_to be_valid
    end

    it "is invalid without a location" do
      venue_without_location = build(:venue, location_id: nil)
      expect(venue_without_location).not_to be_valid
    end
  end
end
