class Project < ActiveRecord::Base
  attr_accessible :description, :id, :name, :repository, :skill, :status, :status, :tagline, :visibility
  
  validates :name, presence: true, uniqueness: {case_sensitive: false}
end
