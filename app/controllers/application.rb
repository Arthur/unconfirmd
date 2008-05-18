class Application < Merb::Controller
  
  protected
  def author
    session[:author_name]
  end
  
  def author=(author)
    session[:author_name] = author
  end
end