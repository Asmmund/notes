require 'spec_helper'
feature 'check frontpage' , js: true do
  before(:all) do
    @u = FactoryGirl.create(:user)
    @a1= FactoryGirl.create(:article, published: true )
    @a2 = FactoryGirl.create(:article, published: false, user_id: @u.id )
  end
  after(:all) do
    User.delete_all; Article.delete_all;
  end

  scenario 'see public articles' do
    visit '/'
    page.should have_content 'Published'
  end
  scenario 'Should allow users to view selected articles' do
    visit '/'
    click_link("View")
    page.should have_content 'Viewing'
  end
  scenario 'don\'t see private articles' do
    visit '/'
    page.should_not have_content 'Private'
  end
  scenario 'existing user should login' do
    login
    page.should have_content 'You\'ll be redirected to your articles '+@u.name
  end

  scenario 'fictional user should not login' do
    visit '/'
    click_link("Login/Signup")
    within("#login_user") do
      fill_in 'Email', :with => 'sdf@fsd.om'
      fill_in 'Password', :with => '23423542'
      click_button('Login')
      click_button('Login')
    end
    page.should have_content 'Wrong email/password!'
  end

  def login
    visit '/'
    click_link("Login/Signup")
    within("#login_user") do
      fill_in 'Email', :with => @u.email
      fill_in 'Password', :with => @u.password
      #TODO solve this error
      click_button('Login')
      click_button('Login')
    end
  end

end

#  feature "test articles", :js => true do

#     before(:each) do
#       @name = create_article
#     end

#     scenario "create article" do
#       page.should have_content(@name)
#     end

#     scenario "make article public" do
#       all('div').select { |elt| elt.text == "Private" }.first.click
#       page.should have_content('Published')
#     end

#     scenario "view article" do
#       link = all('a').select {|elt| elt.text == "View" }.first
#       if link
#         link.click
#         page.should have_content('Viewing')
#       else
#         raise 'No view link found!'
#       end
#     end

#     scenario "edit article" do
#       el =  all('a').select {|elt| elt.text == "Edit" }.first
#       el.click if el
#       page.should have_content('Editing document')
#     end

#     scenario "delete article" do
#       elements_numers = all('a').select {|elt| elt.text == "X" }.count
#       (elements_numers+1).times do
#         el = all('a').select {|elt| elt.text == "X" }.first
#         el.click if el
#         page.driver.browser.switch_to.alert.accept
#       end
#       page.should have_no_content('test')
#     end

#   end
