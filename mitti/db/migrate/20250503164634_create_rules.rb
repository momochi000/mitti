class CreateRules < ActiveRecord::Migration[8.0]
  def change
    create_table :rules do |t|
      t.string :name
      t.text :written_rule
      t.text :functional_rule
      t.text :example_mitigation

      t.timestamps
    end
  end
end
