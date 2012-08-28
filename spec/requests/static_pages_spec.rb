require 'spec_helper'

describe "StaticPages" do

  subject { page }
  
  share_examples_for "all static pages" do
    it { should have_selector('h1', text: heading) }
    it { should have_selector('title', text: full_title(page_title)) }
    it "should have the right links on the layout" do
      click_link "About"
      page.should have_selector('title', text: full_title('About Us'))
      click_link "Help"
      page.should have_selector('title', text: full_title('Help'))
      click_link "Contact"
      page.should have_selector('title', text: full_title('Contact Us'))
      click_link "Home"
      click_link "Sign up now!"
      page.should have_selector('title', text: full_title('Sign up'))
      click_link "My Sample App Link"
      page.should have_selector('title', text: full_title(''))
    end
  end
  
  describe "Home page" do
    before { visit root_path }
    let(:heading)    { 'My Sample App' }
    let(:page_title) { '' }

    it_should_behave_like "all static pages"
    it { should_not have_selector 'title', text: 'Home' }    
  end
  
  describe "Help page" do
    before { visit help_path }
    let(:heading)    { 'Help' }
    let(:page_title) { 'Help' }

    it_should_behave_like "all static pages" 
  end
    
  describe "About Page" do
    before { visit about_path }
    
    let(:heading)    { 'About Us' }
    let(:page_title) { 'About Us' }

    it_should_behave_like "all static pages"     
  end
  
  describe "Contact Us" do
    before { visit contact_path }
    
    let(:heading)    { 'Contact Information' }
    let(:page_title) { 'Contact Us' }

    it_should_behave_like "all static pages"  
  end

end
