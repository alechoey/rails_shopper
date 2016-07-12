class AddIndexForFunnels < ActiveRecord::Migration
  def change
    add_index :applicants, [:created_at, :workflow_state]
  end
end
