class Tag < ApplicationRecord
  has_many :tagmap_postfiles, dependent: :destroy
  has_many :post_files, through: :tagmap_postfiles
  has_many :tagmap_events, dependent: :destroy
  has_many :events, through: :tagmap_events
  validates :name, uniqueness: true
end
