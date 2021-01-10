class AddParticipants < ActiveRecord::Migration[6.1]
  def change
   create_table :participants do |t|
      t.references :room, null: false, foreign_key: true
      t.string :user_session_id
      t.timestamps
    end

    add_column :rooms, :participants_count, :integer
  end
end
