require 'spec_helper'

describe "StaticPages" do

  let(:base_title) { "Ruby on Rails Tutorial Sample App" }
  
  describe "Home page" do
    
    it "should have the content 'Sample App'" do
      visit root_path
      page.should have_selector('h1', :text => 'My Sample App')
    end
    
    it "should have the right title" do
      visit root_path
      page.should have_selector('title',
                    :text => "#{base_title}")
    end
    
    it "should not have '| Home' in the title" do
      visit root_path
      page.should_not have_selector('title', :text => '| Home')
    end
    
  end
  
  describe "Help page" do
  
    it "should have the content 'Help'" do
      visit help_path
      page.should have_selector('h1', :text => 'Help')
    end
     
    it "should have the right title" do
      visit help_path
      page.should have_selector('title',
                    :text => "#{base_title} | Help")
    end
 
  end
    
  describe "About Page" do
    it "should have the content 'About Us'" do
      visit about_path
      page.should have_selector('h1', :text => 'About Us')
    end
    
    it "should have the right title" do
      visit about_path
      page.should have_selector('title',
                    :text => "#{base_title} | About Us")
    end
  end
  
    describe "Contact Us" do
    it "should have the content 'Contact Information'" do
      visit contact_path
      page.should have_selector('h1', :text => 'Contact Information')
    end
    
    it "should have the right title" do
      visit contact_path
      page.should have_selector('title',
                    :text => "#{base_title} | Contact Us")
    end
  end
  

end
