class AddPropertyIdToObservations < ActiveRecord::Migration[8.0]
  def change
    add_reference :observations, :property, null: false, foreign_key: true
  end
end
