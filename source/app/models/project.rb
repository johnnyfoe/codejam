class Project < ActiveRecord::Base
  attr_accessible :description, :id, :name, :repository, :skill, :status, :tagline, :visibility, :owner, :interests
  
  # has_many :users #contributors
  #  has_many :skills
  # belongs_to :user #owner
  has_many :projectToInterestAssociations
  has_many :interests, :through => :projectToInterestAssociations  #, :class_name => 'Interest'
  
  has_many :ratings, dependent: :destroy
  validates :name, presence: true, uniqueness: {case_sensitive: false}
end
