class AddHiddenToRoom < ActiveRecord::Migration[6.1]
  def change
   add_column :rooms, :is_hidden, :boolean
  end
end
