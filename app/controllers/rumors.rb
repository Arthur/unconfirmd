class Rumors < Application
  # provides :xml, :yaml, :js

  def index
    @rumors = Rumor.all
    display @rumors
  end

  def show
    @rumor = Rumor.get()
    raise NotFound unless @rumor
    display @rumor
  end

  def new
    only_provides :html
    @rumor = Rumor.new
    render
  end

  def edit
    only_provides :html
    @rumor = Rumor.get()
    raise NotFound unless @rumor
    render
  end

  def create
    @rumor = Rumor.new(params[:rumor])
    if @rumor.save
      redirect url(:rumor, @rumor)
    else
      render :new
    end
  end

  def update
    @rumor = Rumor.get()
    raise NotFound unless @rumor
    @rumor.attributes = params[:rumor]
    if  @rumor.save
      redirect url(:rumor, @rumor)
    else
      raise BadRequest
    end
  end

  def destroy
    @rumor = Rumor.get()
    raise NotFound unless @rumor
    if @rumor.destroy
      redirect url(:rumor)
    else
      raise BadRequest
    end
  end

end
