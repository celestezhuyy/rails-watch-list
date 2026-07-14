class List < ApplicationRecord
  has_many :bookmarks, dependent: :destroy
  has_many :movies, through: :bookmarks
  has_one_attached :photo

  accepts_nested_attributes_for :bookmarks

  validates :name, uniqueness: true, presence: true
  validates_associated :bookmarks
end
