class ListsController < ApplicationController
  def index
    @lists = List.all
    @new_list = List.new
    @new_list.bookmarks.build
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
    @new_list = List.new(list_params)
    if @new_list.save
      redirect_to list_path(@new_list)
    else
      render turbo_stream: turbo_stream.replace(
        "modal_new_list",
        partial: "lists/form_content",
        locals: { list: @new_list }
      ), status: :unprocessable_entity
    end
  end

  private

  def list_params
    params.expect(list: [:name, :photo, bookmarks_attributes: [[:id, :movie_id, :comment, :_destroy]]])
  end
end
