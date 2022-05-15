class BookmarksController < ApplicationController
  # needs to access list_id
  # to access list_id we need an instance variable which has list_id
  # so we need to get list_id through params (find)
  def new
    @bookmark = Bookmark.new
    @list = List.find(params[:list_id])
  end

  def create
    @bookmark = Bookmark.new(bookmark_params)
    #  need the instance of list so that we can access the data in it
    @list = List.find(params[:list_id])
    #  @bookmark and @list are not linked together right now
    # we need to @bookmark.list = @list to link @bookmark and @list
    @bookmark.list = @list

    if @bookmark.save
      # list_path is looking for an id and needs an instance of list to find it
      redirect_to list_path(@list)
    else
      render :new
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    @bookmark.destroy

    # no need for app/views/restaurants/destroy.html.erb
    redirect_to lists_path
  end

  private

  def bookmark_params
    # :list_id is not coming from user ( since it comes from webpage path)
    # params is a hash and :bookmark is another hash containing keys and we only need to access 2
    params.require(:bookmark).permit(:comment, :movie_id)
  end
end
