class CreateProjectToInterestAssociations < ActiveRecord::Migration
  def change
    create_table :project_to_interest_associations do |t|
      t.integer :project_id
      t.integer :interest_id
      t.integer :skill_required
      t.string :comment

      t.timestamps
    end
  end
end
