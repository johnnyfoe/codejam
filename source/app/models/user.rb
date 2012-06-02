# == Schema Information
#
# Table name: users
#
#  id         :integer         not null, primary key
#  first_name :string(255)
#  surname    :string(255)
#  email      :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class User < ActiveRecord::Base
  attr_accessible :email, :first_name, :surname, :password, :password_confirmation, :pseudonym
  has_secure_password
  has_many :ratings, dependent: :destroy
  has_many :projects
  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token
  
  validates :first_name, presence: true, length: {maximum: 25}
  validates :surname, presence: true, length: {maximum: 25}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: {with: VALID_EMAIL_REGEX}, 
    uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: {minimum: 6}
  validates :password_confirmation, presence: true
  VALID_ALIAS_REGEX = /^(\w{3,})$/
  validates :pseudonym, presence: true, length: {maximum: 50}, 
    format: {with: VALID_ALIAS_REGEX}, uniqueness: { case_sensitive: true}
  
  private
  
  def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
  end
end
