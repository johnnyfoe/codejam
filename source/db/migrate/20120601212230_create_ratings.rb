class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.references :users
      t.references :projects
      t.integer :code_quality
      t.integer :effort
      t.integer :communication_skills
      t.string :code_quality_just
      t.string :effort_just
      t.string :communication_skills_just
      t.string :general

      t.timestamps
    end
    add_index :ratings, [:users, :created_at]
	add_index "ratings", ["projects", "created_at"], :name => "index_ratings_on_project_id_and_created_at"
  end
end
