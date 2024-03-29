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

require 'spec_helper'

describe User do
  before { @user = User.new(first_name: "Example", surname: "User", email: "user@example.com",
    password: "foobar", password_confirmation: "foobar", pseudonym: "User")}
  subject { @user }
  it { should respond_to(:first_name) }
  it { should respond_to(:surname) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:remember_token) }
  it { should respond_to(:admin) }
  it { should respond_to(:authenticate) }
  it { should respond_to(:ratings) }
  it { should respond_to(:pseudonym) }
  
  it { should be_valid }
  it { should_not be_admin}
  
  describe "with admin attribute set to 'true'" do
    before { @user.toggle!(:admin) }
    
    it{ should be_admin }
  end
  
  describe "when first name is not present" do
    before { @user.first_name = " "}
    it { should_not be_valid}
  end
  
  describe "when surname is not present" do
    before { @user.surname = " "}
    it { should_not be_valid}
  end
  
  describe "when email is not present" do
    before { @user.email = " "}
    it { should_not be_valid}
  end
  
  describe "when password is not present" do
    before { @user.password = @user.password_confirmation = " " }
    it { should_not be_valid }
  end
  
  describe "when password doesn't match confirmation" do
    before { @user.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end
  
  describe "when password confirmation is nil" do
    before { @user.password_confirmation = nil }
    it { should_not be_valid }
  end
  
  describe "finding a user by their pseudonym" do
    before{ @user.save }
    let( :found_user ) {User.find_by_pseudonym( @user.pseudonym ) }
    
    it { should == found_user}
  end
  
  describe "return value of authenticate method" do
    before { @user.save }
    let(:found_user) { User.find_by_email(@user.email) }

    describe "with valid password" do
      it { should == found_user.authenticate(@user.password) }
    end
    
    describe "with invalid password" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid")}
      
      it { should_not == user_for_invalid_password }
      specify { user_for_invalid_password.should be_false}
    end
  end
  
  describe "with a password that's too short" do
    before { @user.password = @user.password_confirmation = "a" * 5}
    it { should be_invalid }
  end
  
  describe "when email address is already taken" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.email = @user.email.upcase
      user_with_same_email.save
    end
    it { should_not be_valid }
  end
  
  describe "when alias is already taken" do
    before do
      user_with_same_pseudonym = @user.dup
      user_with_same_pseudonym.pseudonym = @user.pseudonym.upcase
      user_with_same_pseudonym.save
    end
    it { should_not be_valid }
  end
  
  describe "remember token" do
    before {@user.save}
    its(:remember_token) { should_not be_blank }
  end
end
