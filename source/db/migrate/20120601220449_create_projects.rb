class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.integer :id
      t.string :name
      t.string :status
      t.string :tagline
      t.string :description
      t.references :skill
      t.string :repository
      t.string :visibility
      t.string :status

      t.timestamps
    end
  end
end
