require 'spec_helper'

describe "MicropostPages" do
  
  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "micropost creation" do
    before { visit root_path }
    
    describe "with invalid information" do
      
      it "should not create a micropost" do
        expect { click_button "Post" }.not_to change(Micropost, :count)
      end

      describe "error messages" do
        before { click_button "Post" }
        it { should have_content('error') } 
      end
    end

    describe "with valid information" do

      before { fill_in 'micropost_content', with: "Lorem ipsum" }
      it "should create a micropost" do
        expect { click_button "Post" }.to change(Micropost, :count).by(1)
      end
    end
  end
  
  describe "micropost destruction" do
    before { FactoryGirl.create(:micropost, user: user) }
        
    describe "as correct user" do
      before { visit root_path }
      
      it "should delete a micropost" do
        expect { click_link "delete" }.to change(Micropost, :count).by(-1)
      end
    end
  end
  
  describe "micropost counts" do

    describe "with 0 posts" do
      before { visit root_path }
      it { should have_content('0 microposts') }
    end
    
    describe "with 1 post" do
      before do 
        FactoryGirl.create(:micropost, user: user)
        visit root_path
      end 
      it { should have_content('1 micropost') }
    end
    
    describe "with 2 posts" do
      before do 
        FactoryGirl.create(:micropost, user: user)
        FactoryGirl.create(:micropost, user: user)
        visit root_path
      end
      it { should have_content('2 microposts') }
    end  
  end
  
  describe "micropost pagination" do
    before(:all) { 50.times { FactoryGirl.create(:micropost, user: user) } }
    after(:all) { user.microposts.delete_all }
    
    describe "page" do
      before { visit root_path }
      it "should list each micropost" do
        user.feed.paginate(page: 1).each do |post|
          page.should have_selector('li', text: post.content)
        end
      end

      describe "2" do
        before { click_link('2') }
        it "should list each micropost" do
          user.feed.paginate(page: 2).each do |post|
            page.should have_selector('li', text: post.content)
          end
        end
      end 
    end
   
  end

end
