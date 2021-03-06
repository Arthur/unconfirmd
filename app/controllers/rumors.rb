class Rumors < Application
  # provides :xml, :yaml, :js
  provides :js
  
  def index
    @rumors = Rumor.all
    display @rumors
  end

  def show
    @rumor = Rumor.get(params[:id])
    @comment = Comment.new(:author => author)
    @comment.rumor = @rumor
    raise NotFound unless @rumor
    display @rumor
  end

  def new
    only_provides :html
    @rumor = Rumor.new(:author => author)
    render
  end

  def edit
    only_provides :html
    @rumor = Rumor.get(params[:id])
    raise NotFound unless @rumor
    render
  end

  def create
    @rumor = Rumor.new(params[:rumor])
    self.author = @rumor.author
    if @rumor.save
      redirect url(:rumor, @rumor)
    else
      render :new
    end
  end

  def update
    @rumor = Rumor.get(params[:id])
    raise NotFound unless @rumor
    @rumor.attributes = params[:rumor]
    if  @rumor.save
      redirect url(:rumor, @rumor)
    else
      raise BadRequest
    end
  end

  def destroy
    @rumor = Rumor.get(params[:id])
    raise NotFound unless @rumor
    if @rumor.destroy
      redirect url(:rumor)
    else
      raise BadRequest
    end
  end

  def plus
    @rumor = Rumor.get(params[:id])
    @rumor.plus
    if  @rumor.save
      if params[:format]=='js'
        render
      else
        redirect url(:rumor, @rumor)
      end
    else
      raise BadRequest
    end
  end
  
  def minus
    @rumor = Rumor.get(params[:id])
    @rumor.minus
    if  @rumor.save
      if params[:format]=='js'
        render
      else
        redirect url(:rumor, @rumor)
      end
    else
      raise BadRequest
    end
  end

end
