class Favorite < ApplicationRecord
    belongs_to :user
    belongs_to :post_file
end
