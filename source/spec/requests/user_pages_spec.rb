require 'spec_helper'

describe "UserPages" do
  subject { page }
  
  describe "index" do
    
    let(:user) { FactoryGirl.create(:user) }
    
    before(:all) { 30.times { FactoryGirl.create(:user) } }
    after(:all) { User.delete_all }
    
    before(:each) do
      sign_in user
      visit users_path
    end
    
    it { should have_selector('title', text: "All users")}
    it { should have_selector('h1', text: "All users")}
    
    describe "pagination" do
      it { should have_selector('div.pagination')}
      it "should list each user" do
        User.paginate(page: 1).each do |user|
          page.should have_selector('li', text: user.first_name)
        end
      end
    end
    
    
    #These tests here need to be modified, on a user's setting page they should be able to delete themselves.
    #This test should be in the other areas where settings are tested.
    
    #Test to be implemented:
      #Navigate to some other user's settings page (I shouldn't be able to access this but try it anyway)
      #Navigate to the current user's settings page. 
      #Check to see if the user's setting page has a delete link/button
      #Delete the user (Make sure the functionality works.)
    #describe "delete links" do
      
    #  it { should_not have_link('delete') }
      
    #  describe "as an admin user" do
    #    let(:admin) { FactoryGirl.create(:admin) }
        
    #    before do
    #      visit root_path
    #      click_link('Sign out')
    #      sign_in admin
    #      visit users_path
    #    end
        
    #    it { should have_link('delete', href: user_path(User.first) ) }
    #    it "should be able to delete another user" do
    #      expect { click_link('delete') }.to change(User, :count).by(-1)
    #    end
    #    it { should_not have_link('delete', href: user_path(admin) ) }
    #  end
    #end
  end
  
  describe "signup page" do
    before { visit signup_path }
    
    it { should have_selector('h1', :text => 'Codej.am Prototype') }
    it { should have_selector('title', :text => full_title('')) }
    it { should_not have_selector('title', :text => "| Index") }
  end
  
  describe "profile page" do
    # Code to make a user variable
    let(:user) { FactoryGirl.create(:user) }
	let!(:m1) { FactoryGirl.create(:rating, user: user, effort: "1") }
	let!(:m2) { FactoryGirl.create(:rating, user: user, effort: "3") }
    before { visit user_path(user) }
    it { should have_selector('h1', text: "#{user.first_name} #{user.surname}")}
	
	describe "ratings" do
      it { should have_content(m1.effort) }
      it { should have_content(m2.effort) }
      it { should have_content(user.ratings.count) }
    end
  end
  
  describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
    before { 
      sign_in user
      visit edit_user_path(user) 
    }
    
    describe "page" do
      it { should have_selector('h1', text: "Update your profile")}
      it { should have_selector('title', text: "Edit user") }
      it { should have_link('change', href: 'http://gravatar.com/emails')}
      it { should have_link('delete', href: user_path(user.pseudonym) ) }
      it "should be able to delete current user" do
        expect { click_link('delete') }.to change(User, :count).by(-1)
      end
    end
    
    describe "with invalid information" do
      before { click_button "Save changes" }
      
      it { should have_content('error') }
    end
    
    describe "with valid information" do
      let(:new_first_name) { "New" }
      let(:new_surname) { "Name" }
      let(:new_email) { "new@example.com" }
      let(:new_pseudonym) { "New_User"}
      
      before do
        fill_in "First name", with: new_first_name
        fill_in "Surname", with: new_surname
        fill_in "Email", with: new_email
        fill_in "Pseudonym", with: new_pseudonym
        fill_in "Password", with: user.password
        fill_in "Confirm Password", with: user.password
        click_button "Save changes"
      end
      
      it { should have_selector('title', text: new_first_name) }
      it { should have_selector('div.alert.alert-success') }
      it { should have_link('Sign out', href: signout_path) }
      specify{ user.reload.first_name.should == new_first_name }
      specify{ user.reload.surname.should == new_surname }
      specify{ user.reload.pseudonym.should == new_pseudonym }
      specify{ user.reload.email.should == new_email }

    end
    
  end
  
  
end
