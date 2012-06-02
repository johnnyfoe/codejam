require 'spec_helper'

describe Rating do
  #pending "add some examples to (or delete) #{__FILE__}"
  let(:user) { FactoryGirl.create(:user) }
  let(:project) { FactoryGirl.create(:project) }
  #Possible security issue, user_id and project_id should not be accessible
  #Can build association with one but not two - see tutorial ch10.1.3
  before do @rating = user.ratings.build(project_id: project.id, code_quality: 2, 
    code_quality_just: "messy code, poorly commented", effort: 2, effort_just: "lazy",
    communication_skills: 1, communication_skills_just: "never spoke",
    general: "poor programmer, would not recommend") 	
  end
    
  subject { @rating }

  it { should respond_to(:user_id) }
  it { should respond_to(:project_id) }
  it { should respond_to(:code_quality) }
  it { should respond_to(:code_quality_just) }
  it { should respond_to(:effort) }
  it { should respond_to(:effort_just) }
  it { should respond_to(:communication_skills) }
  it { should respond_to(:communication_skills_just) }
  it { should respond_to(:general) }
  
  it { should respond_to(:user) }
  it { should respond_to(:project) }
  its(:user) { should == user }
  it { should be_valid }
  
  describe "when general is too long" do
      before { @rating.general = "a" * 141 }
    it { should_not be_valid }
  end
  
  describe "when general is less than 140 characters" do
    before { @rating.general = "a" * 35 }
    it { should be_valid }
  end
  
  describe "when code_quality_just is too long" do
    before { @rating.general = "a" * 141 }
    it { should_not be_valid }
  end
  
  describe "when effort_just is too long" do
    before { @rating.general = "a" * 141 }
    it { should_not be_valid }
  end
  
  describe "when communication_skills_just is too long" do
    before { @rating.general = "a" * 141 }
    it { should_not be_valid }
  end
  
  describe "when user_id is not present" do
    before { @rating.user_id = "" }
    it { should_not be_valid }
  end  
  
  describe "when user_id is not present" do
    before { @rating.user_id = "" }
    it { should_not be_valid }
  end  
  
  describe "when rating is not valid" do
    it "should not be valid" do
      ratings = [7, 0, -1]
      ratings.each do |invalid_rating|
        @rating.code_quality = invalid_rating
        @rating.should_not be_valid
      end      
    end
   end
  
  describe "when rating is valid" do
    it "should be valid" do
      ratings = [1, 3, 5]
      ratings.each do |valid_rating|
        @rating.code_quality = valid_rating
        @rating.should be_valid
      end      
    end
   end
  
    describe "when rating is valid" do
    it "should be valid" do
      ratings = [1, 3, 5]
      ratings.each do |valid_rating|
        @rating.code_quality = valid_rating
        @rating.should be_valid
      end      
    end
   end
  describe "accessible attributes" do
    it "should not allow access to user_id" do
      expect do
        Rating.new(user_id: user.id)
      end.should raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end  
	it "should not allow access to project_id" do
      expect do
        Rating.new(project_id: project.id)
      end.should raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end    	
  end
   
end




