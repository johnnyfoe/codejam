require 'composite_primary_keys'
class Rating < ActiveRecord::Base
  attr_accessible :code_quality, :code_quality_just, :communication_skills, :communication_skills_just, :effort, :effort_just, :general, :project_id #, :user_id, 
      
  self.primary_keys = [:user_id, :project_id]
  belongs_to :user#, :foreign_key => 'id', :primary_key => :user_id
  belongs_to :project#, :foreign_key => 'id', :primary_key => :project_id
  	  
  validates :general, length: { maximum: 140 }
  validates :user_id, presence: true
  validates :project_id, presence: true
  validates :code_quality, presence: true, :inclusion => { :in => 1..5 }, 
  :numericality => true, :length => { :maximum => 1 }
  validates :effort, presence: true, :inclusion => { :in => 1..5 }, 
  :numericality => true, :length => { :maximum => 1 }
  validates :communication_skills, presence: true, :inclusion => { :in => 1..5 }, 
  :numericality => true, :length => { :maximum => 1 }
  validates :communication_skills_just, length: { maximum: 140 }
  validates :effort_just, length: { maximum: 140 }
  validates :code_quality_just, length: { maximum: 140 }

  #default_scope order:
end
