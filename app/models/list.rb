class List < ApplicationRecord
  has_many :bookmarks, dependent: :destroy
  has_many :movies, through: :bookmarks
  has_one_attached :photo

  accepts_nested_attributes_for :bookmarks, reject_if: :all_blank, allow_destroy: true

  validates :name, uniqueness: true, presence: true
  validates_associated :bookmarks
  validate :unique_movies_in_bookmarks

  private

  def unique_movies_in_bookmarks
    active_bookmarks = bookmarks.reject(&:marked_for_destruction?)
    seen_movie_ids = []
    has_duplicates = false

    active_bookmarks.each do |bookmark|
      next if bookmark.movie_id.blank?
      if seen_movie_ids.include?(bookmark.movie_id)
        bookmark.errors.add(:movie_id, "has already been selected in this list")
        has_duplicates = true
      else
        seen_movie_ids << bookmark.movie_id
      end
    end
    if has_duplicates
      errors.add(:base, "You cannot add the same movie multiple times.")
    end
  end
end
