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
  attr_accessible :email, :first_name, :surname, :password, :password_confirmation
  has_secure_password
  
  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token
  
  validates :first_name, presence: true, length: {maximum: 25}
  validates :surname, presence: true, length: {maximum: 25}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: {with: VALID_EMAIL_REGEX}, uniqueness: { case_sensative: false }
  validates :password, presence: true, length: {minimum: 6}
  validates :password_confirmation, presence: true
  
  private
  
  def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
  end
end
