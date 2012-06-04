require 'spec_helper'

describe "Home" do
  subject { page }
  
  describe "index" do
    before { visit root_path }
    it { should have_selector('h1', :text => 'Codej.am Prototype') }
    it { should have_selector('title', :text => full_title('')) }
    it { should_not have_selector('title', :text => "| Index") }
  end
  
  describe "help" do
    before { visit help_path }
    it { should have_selector('h1', :text => "Help with Codej.am") }
    it { should have_selector('title', :text => full_title("Help")) }
  end
  
  describe "about" do
    before { visit about_path }
    it { should have_selector('h1', :text => "About Codej.am") }
    it { should have_selector('title', :text => full_title("About")) }
  end
  
  describe "privacy" do
    before { visit privacy_path }
    it { should have_selector('h1', :text => "Codej.am and privacy") }
    it { should have_selector('title', :text => full_title("Privacy")) }
  end
  
  describe "contact" do
    before { visit contact_path }
    it { should have_selector('h1', :text => "Contacting the Codej.am developers") }
    it { should have_selector('title', :text => full_title("Contact")) }
  end
  
  describe "legal" do
    before { visit legal_path }
    it { should have_selector('h1', :text => "Codej.am legal mumbo jumbo") }
    it { should have_selector('title', :text => full_title("Legal")) }
  end
  
  describe "signup" do
    before { visit signup_path }
    let(:submit) { "Create my account" }
    
    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
    end
    
    describe "with valid information" do
      before do
        fill_in "First name", with:"Example middle"
        fill_in "Surname", with:"User"
        fill_in "Signup Email", with:"user@codej.am"
        fill_in "New Password", with: "foobar"
        fill_in "Confirmation", with: "foobar"
      end
      
      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end
      
    end
    
  end 
    
  describe "signin page" do
    before { visit signin_path }
    it { should have_selector('h1', :text => 'Codej.am Prototype') }
    it { should have_selector('title', :text => full_title('')) }
    it { should_not have_selector('title', :text => "| Index") }
  end
    
  describe "signin" do
    before { visit signin_path }
    
    describe "with invalid information" do
      
      before { click_button "Sign in" }
       
      it { should have_selector( 'div.alert.alert-error', text: 'Invalid')}
      describe "after visiting another page" do
        before { click_link "Codej.am" }
        it { should_not have_selector("div.alert.alert-error")}
      end
    end
      
    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        fill_in "Email", with: user.email
        fill_in "Password", with: user.password
        click_button "Sign in"
      end
        
      it { should have_selector('title', text: user.first_name) }
      it { should have_link("#{user.first_name} #{user.surname}", href: user_path(user.pseudonym) ) }
      it { should have_link('Settings', href: edit_user_path(user.pseudonym) ) }
      it { should have_link('Sign out', href: signout_path) }
      it { should_not have_link('Sign in', href: signin_path) }
      
      describe "followed by signout" do
        before { click_link "Sign out" }
        it { should have_selector('input', value: 'Sign in')}
      end
    end
      
  end
  
  describe "authorization" do

    describe "as non-admin user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:non_admin) { FactoryGirl.create(:user) }
      
      before { sign_in non_admin }
      describe "submitting a DELETE request to the User#destroy action" do
        before { delete user_path(user) }
        specify { response.should redirect_to(root_path) }
      end
    end

    describe "for non-signed-in-users" do
      let(:user) { FactoryGirl.create(:user) }
      
      describe "when attempting to visit a protected page" do
        before do
          visit edit_user_path(user)
          fill_in "Email", with: user.email
          fill_in "Password", with: user.password
          click_button "Sign in"
        end
        
        describe "after signing in" do
          
          it "should render the desired protected page" do
            page.should have_selector('title', test: 'Edit_user')
          end
        end
        
      end
      
      describe "in the Users controller" do
        
        describe "visiting the edit page" do
          before { visit edit_user_path(user) }
          it { should have_selector('title', :text => full_title('')) }
          it { should_not have_selector('title', :text => "| Index") }
        end
        
        describe "submitting to the update action" do
          before { put user_path(user) }
          specify { response.should redirect_to(signin_path) }
        end
        
        describe "visiting the user index" do
          before { visit users_path}
          it { should have_selector('title', :text => full_title('')) }
          it { should_not have_selector('title', :text => "| Index") }
        end
      end
    end
    
    describe "as wrong user" do
      let(:user) {FactoryGirl.create(:user)}
      let(:wrong_user) {FactoryGirl.create(:user, email: "wrong@example.com")}
      before { sign_in user }
      
      describe "visiting Users#edit page" do
        before { visit edit_user_path(wrong_user) }
        it { should_not have_selector('title', text: full_title('Codej.am | Edit user') ) }
      end
      
      describe "submitting a PUT request to the Users#update action" do
        before { put user_path(wrong_user) }
        specify { response.should redirect_to(root_path) }
      end
      
    end
    
    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      before { sign_in user }
      
      it { should have_selector('title', text: user.first_name) }
      
      it { should have_link('Users', href: users_path ) }
      it { should have_link("#{user.first_name} #{user.surname}", href: user_path(user.pseudonym) ) }
      it { should have_link('Settings', href: edit_user_path(user.pseudonym) ) }
      it { should have_link('Sign out', href: signout_path ) }
      
      it { should_not have_link('Sign in', href: signin_path)}
    end
  end
  
end
