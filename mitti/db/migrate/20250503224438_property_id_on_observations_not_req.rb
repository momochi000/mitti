class PropertyIdOnObservationsNotReq < ActiveRecord::Migration[8.0]
  def change
    change_column :observations, :property_id, :integer
  end
end
