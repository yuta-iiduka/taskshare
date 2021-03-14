class TagmapPostfile < ApplicationRecord
  belongs_to :post_file
  belongs_to :tag
end
