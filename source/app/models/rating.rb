class Rating < ActiveRecord::Base
  attr_accessible :code_quality, :code_quality_just, :communication_skills, :communication_skills_just, :effort, :effort_just, :general, :project_id, :user_id
end
