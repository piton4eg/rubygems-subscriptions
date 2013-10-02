class AddStatesToGems < ActiveRecord::Migration
  def change
    add_column :ruby_gems, :version, :string
  end
end
