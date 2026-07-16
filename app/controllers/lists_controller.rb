class ListsController < ApplicationController
  before_action :set_list, only: [:show, :destroy, :edit]

  def index
    @lists = List.all
    @new_list = List.new
    @new_list.bookmarks.build
  end

  def show
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

    def destroy
      @list.destroy
      redirect_to root_path, status: :see_other
    end

    def edit
    end

    def update
      @list = List.update(list_params)
      redirect_to list_path(@list)
    end

    private

    def list_params
      params.expect(list: [:name, :photo, bookmarks_attributes: [[:id, :movie_id, :comment, :_destroy]]])
    end

    def set_list
      @list = List.find(params[:id])
    end
end
