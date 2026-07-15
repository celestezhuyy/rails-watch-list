class List < ApplicationRecord
  has_many :bookmarks, dependent: :destroy
  has_many :movies, through: :bookmarks
  has_one_attached :photo

  accepts_nested_attributes_for :bookmarks, reject_if: :all_blank, allow_destroy: true

  validates :name, uniqueness: true, presence: true
  validates_associated :bookmarks
end
