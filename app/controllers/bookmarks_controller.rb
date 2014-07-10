class BookmarksController < ApplicationController
  expose(:bookmarks)
  expose(:bookmark, attributes: :bookmark_params)

  def create
    byebug
    bookmark.user = current_user
    if bookmark.save
      redirect_to bookmarks_path, notice: 'Bookmark saved'
    else
      render :new
    end
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:link, :topic)
  end
end
