class AddBackgroundCheckConfirmedToApplicants < ActiveRecord::Migration
  def change
    add_column :applicants, :background_check_confirmed, :boolean, :default => false
  end
end
