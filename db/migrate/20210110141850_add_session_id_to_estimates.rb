class AddSessionIdToEstimates < ActiveRecord::Migration[6.1]
  def change
   add_column :estimates, :user_session_id, :string
  end
end
