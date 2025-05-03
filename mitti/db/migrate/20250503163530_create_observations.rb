class CreateObservations < ActiveRecord::Migration[8.0]
  def change
    create_table :observations do |t|
      t.json :content

      t.timestamps
    end
  end
end
