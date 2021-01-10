class CreateEstimates < ActiveRecord::Migration[6.1]
  def change
    create_table :estimates do |t|
      t.references :room, null: false, foreign_key: true
      t.integer :value

      t.timestamps
    end
  end
end
