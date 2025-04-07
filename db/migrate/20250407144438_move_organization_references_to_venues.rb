class MoveOrganizationReferencesToVenues < ActiveRecord::Migration[8.0]
  def change
    remove_reference :locations, :organization, foreign_key: true
    add_reference :venues, :organization, foreign_key: true
  end
end
