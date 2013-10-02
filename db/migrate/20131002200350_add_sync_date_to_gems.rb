class AddSyncDateToGems < ActiveRecord::Migration
  def change
    add_column :ruby_gems, :sync_date, :datetime
  end
end
