class Interest < ActiveRecord::Base
  attr_accessible :description, :id, :name
  
  has_and_belongs_to_many :projects  #, :class_name => 'Project'
end
