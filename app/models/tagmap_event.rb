class TagmapEvent < ApplicationRecord
  belongs_to :event
  belongs_to :tag
end
