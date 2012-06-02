class AddAliasToUsers < ActiveRecord::Migration
  def change
    add_column :users, :pseudonym, :string
  end
end
