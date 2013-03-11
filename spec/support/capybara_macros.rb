module CapybaraMacros
  def create_article
    name = 'test'+rand(100).to_s
    visit '/articles'
    fill_in 'name', with: name
    click_button 'create_article'
    name
  end

end