class AddColumnOpenIdToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :open_id, :string
  end
end
