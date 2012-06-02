class Project < ActiveRecord::Base
  attr_accessible :description, :id, :name, :repository, :skill, :status, :tagline, :visibility, :owner, :interests
  
  # has_many :users #contributors
  #  has_many :skills
  # belongs_to :user #owner
  has_and_belongs_to_many :interests  #, :class_name => 'Interest'
  
  attr_accessible :description, :id, :name, :repository, :skill, :status, :status, :tagline, :visibility, :owner
  has_many :ratings, dependent: :destroy
  validates :name, presence: true, uniqueness: {case_sensitive: false}
end
