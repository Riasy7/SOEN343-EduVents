require 'rails_helper'

RSpec.describe Organization, type: :model do
  context "validations" do
    it "is valid with valid attributes" do
      organization = build(:organization)
      expect(organization).to be_valid
    end

    it "is invalid without a name" do
      organization_without_name = build(:organization, name: nil)
      expect(organization_without_name).not_to be_valid
      expect(organization_without_name.errors[:name]).to include("can't be blank")
    end

    it "is invalid with an invalid website" do
      organization_with_invalid_website = build(:organization, website: "invalid_url")
      expect(organization_with_invalid_website).not_to be_valid
      expect(organization_with_invalid_website.errors[:website]).to include("must be a valid URL")
    end

    it "is invalid with an invalid phone number" do
      organization_with_invalid_phone = build(:organization, phone: "invalid_phone")
      expect(organization_with_invalid_phone).not_to be_valid
      expect(organization_with_invalid_phone.errors[:phone]).to include("must be a valid phone number")
    end

    it "is invalid without at least one location" do
      organization_without_locations = create(:organization)
      organization_without_locations.locations.destroy_all
      expect(organization_without_locations).not_to be_valid
      expect(organization_without_locations.errors[:locations]).to include("must have at least one location")
    end

    it "is invalid with duplicate locations" do
      organization = create(:organization)
      location = create(:location, name: "SGW Campus", organization: organization)
      duplicate_location = build(:location, name: "SGW Campus", organization: organization)
      expect(duplicate_location).not_to be_valid
      expect(duplicate_location.errors[:name]).to include("must be unique within the same organization")
    end
  end

  context "associations" do
    it "has many users" do
      association = described_class.reflect_on_association(:users)
      expect(association.macro).to eq(:has_many)
    end

    it "has many locations" do
      association = described_class.reflect_on_association(:locations)
      expect(association.macro).to eq(:has_many)
    end
  end
end