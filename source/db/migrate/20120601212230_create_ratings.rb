class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.string :user_id
      t.string :project_id
      t.integer :code_quality
      t.integer :effort
      t.integer :communication_skills
      t.string :code_quality_just
      t.string :effort_just
      t.string :communication_skills_just
      t.string :general

      t.timestamps
    end
    add_index :ratings, [:user_id, :created_at]
  end
end
