require 'spec_helper'
feature 'check frontpage' , js: true do
  before(:all) do
    @u = FactoryGirl.create(:user)
    @a2 = FactoryGirl.create(:article, user_id: @u.id )
    @a1 = FactoryGirl.create(:article, published: true, user_id: @u.id )
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
  scenario 'should let signup' do
    visit '/'
    click_link("Login/Signup")
    click_link("Signup")
    within("#create_user") do
      fill_in 'name', :with => 'Alfred'
      fill_in 'password', :with => 'Hitchcock'
      fill_in 'password_confirmation', :with => 'Hitchcock'
    end
    page.should_not have_content 'User was created, you\'ll be redirected to the main page and you can login'
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

  describe 'checking logged in user' do
    before(:each) do
      login
    end


    scenario 'can login & see private article' do
      page.has_css?('form#new_article')
      page.should have_content 'String_3'
    end

    scenario 'should be able to view articles' do
      page.should have_content('View')
      link = all('a').select {|elt| elt.text == "View" }.first
      link.click
      page.should have_content('Viewing')
    end

    scenario 'should be able to edit articles' do
      page.should have_content('Edit')
      link = all('a').select {|elt| elt.text == "Edit" }.first
      link.click
      page.should have_content('Editing document')
    end

    scenario 'should be able to create article and set it\'s options' do
      page.should have_content('Create article')
      within("#new_article") do
        fill_in 'new_article_name', :with => 'Super Title'
        click_button('create_article')
      end
      click_button('create_article')
      page.should have_content('Editing document')
      all('div').select { |elt| elt.text == "Private" }.first.click
      page.should have_content('Published')
      click_button('save_article')
      page.should have_content('Super Title')
    end

    scenario "delete article" do
      page.should have_content('X')
      elements_numers = all('a').select {|elt| elt.text == "X" }.count
      (elements_numers).times do
        el = all('a').select {|elt| elt.text == "X" }.first
        el.click
        page.driver.browser.switch_to.alert.accept
      end
      page.should have_no_content('View')
    end
  end

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
