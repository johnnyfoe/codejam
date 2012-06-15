class ProjectToInterestAssociation < ActiveRecord::Base
  attr_accessible :comment, :skill_required
  
  belongs_to :project
  belongs_to :interest
end
