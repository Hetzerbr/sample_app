require 'spec_helper'

describe "User pages" do

  subject { page }

  describe "signup page" do
    before { visit signup_path }

    let(:submit) { "Create my account" }

    it { should have_selector('h1', :text => 'Sign up') }
    it { should have_selector('title', :text => full_title('Sign up')) }

  describe "with invalid information" do
    it "should not create a user" do
    expect { click_button submit }.not_to change(User, :count)
  end

  describe "after submission" do
    before { click_button submit }

    it { should have_selector('title', :text => 'Sign up') }
    it { should have_content('error') }
  end
end

  describe "with valid information" do
    let(:user) { FactoryGirl.create(:user) }
    before { sign_up(user) }

    it "should create a user" do
      expect { click_button submit }.to change(User, :count).by(1)
    end

    describe "after saving the user" do
      before { click_button submit }
      let(:editeduser) { User.find_by_email('user@example.com') }

      it { should have_selector('title', :text => editeduser.name) }
      it { should have_selector('div.alert.alert-success', :text => 'Welcome') }
      it { should have_link('Sign out') }
      end
    end
  end
end