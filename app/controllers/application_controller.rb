class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  before_action :set_lists, :build_new_list

  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  private

  def set_lists
    @lists = List.all
  end

  def build_new_list
    @new_list = List.new
    @new_list.bookmarks.build
  end
end
