class AddObservedAtToObservation < ActiveRecord::Migration[8.0]
  def change
    add_column :observations, :observed_at, :datetime
  end
end
