class AddIndexOnPseudonymToUsers < ActiveRecord::Migration
  def change
    add_index :users, :pseudonym, unique: true
  end
end
