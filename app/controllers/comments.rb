class Comments < Application
  # provides :xml, :yaml, :js
  before :find_rumor
  
  def index
    @comments = Comment.all
    display @comments
  end

  def new
    only_provides :html
    @comment = Comment.new
    @comment.rumor = @rumor
    render
  end

  def edit
    only_provides :html
    @comment = Comment.get()
    @comment.rumor = @rumor
    raise NotFound unless @comment
    render
  end

  def create
    @comment = Comment.new(params[:comment])
    @comment.rumor = @rumor
    self.author = @comment.author
    
    if @comment.save
      redirect url(:rumor, @rumor)
    else
      render :new
    end
  end

  protected
  def find_rumor
    @rumor = Rumor.get(params[:rumor_id])
  end
  
end
