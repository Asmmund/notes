module MainHelper
  def get_articles
    if session[:user_id].nil?
      return Article.where(published: true)
    else
      return User.find(session[:user_id]).articles
    end


  end
end
