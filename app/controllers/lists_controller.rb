class ListsController < ApplicationController
  def index
    @lists = List.all
    @list = List.new
    @list.bookmarks.build
  end

  def show
    @list = List.find(params[:id])
    @movies = @list.movies
    @bookmark = Bookmark.new
  end

  def new
    @list = List.new
    @list.bookmarks.build
  end

  def create
    @list = List.new(list_params)
    if @list.save
      redirect_to list_path(@list)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def list_params
    params.expect(list: [:name, :photo, bookmarks_attributes: [:movie_id, :comment]])
  end
end
