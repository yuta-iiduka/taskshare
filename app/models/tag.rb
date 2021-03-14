class Tag < ApplicationRecord
  has_many :tagmap_postfiles, dependent: :destroy
  has_many :post_files, through: :tagmap_postfiles
  validates :name, uniqueness: true
end
