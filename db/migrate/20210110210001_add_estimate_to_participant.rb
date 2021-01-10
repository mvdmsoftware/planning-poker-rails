class AddEstimateToParticipant < ActiveRecord::Migration[6.1]
  def change
   add_column :participants, :estimate, :integer
   drop_table :estimates
  end
end
