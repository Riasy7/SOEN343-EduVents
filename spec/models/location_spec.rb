require 'rails_helper'

RSpec.describe Location, type: :model do
  context "validations" do
    it "is valid with valid attributes" do
      location = build(:location)
      expect(location).to be_valid
    end

    it "is invalid without a name" do
      location = build(:location, name: nil)
      expect(location).not_to be_valid
      expect(location.errors[:name]).to include("can't be blank")
    end

    it "is invalid without an address1" do
      location = build(:location, address1: nil)
      expect(location).not_to be_valid
      expect(location.errors[:address1]).to include("can't be blank")
    end

    it "is invalid without a city" do
      location = build(:location, city: nil)
      expect(location).not_to be_valid
      expect(location.errors[:city]).to include("can't be blank")
    end

    it "is invalid without a state" do
      location = build(:location, state: nil)
      expect(location).not_to be_valid
      expect(location.errors[:state]).to include("can't be blank")
    end

    it "is invalid without a country" do
      location = build(:location, country: nil)
      expect(location).not_to be_valid
      expect(location.errors[:country]).to include("can't be blank")
    end

    it "is invalid with a duplicate name within the same organization" do
      organization = create(:organization)
      create(:location, name: "SGW Campus", organization: organization)
      duplicate_location = build(:location, name: "SGW Campus", organization: organization)
      expect(duplicate_location).not_to be_valid
      expect(duplicate_location.errors[:name]).to include("must be unique within the same organization")
    end
  end

  context "associations" do
    it "belongs to an organization" do
      association = described_class.reflect_on_association(:organization)
      expect(association.macro).to eq(:belongs_to)
    end
  end
end