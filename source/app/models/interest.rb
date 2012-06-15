class Interest < ActiveRecord::Base
  attr_accessible :description, :id, :name, :familiarity
  
  has_many :projectToInterestAssociations
  has_many :projects, :through => :projectToInterestAssociations
end
