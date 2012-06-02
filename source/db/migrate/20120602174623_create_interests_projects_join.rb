class CreateInterestsProjectsJoin < ActiveRecord::Migration
  def up
    create_table 'interests_projects', :id => false do |t|
      t.column 'interest_id', :integer
      t.column 'project_id', :integer
    end
  end

  def down
    drop_table 'interests_projects'
  end
end