class PostFile < ApplicationRecord
    has_many_attached :files
    belongs_to :user
    has_many :post_comments, dependent: :destroy
    
    #検索機能
    def self.search(search,word)
      if search == "forward_math"
        @postfiles = PostFile.where("title LIKE?","#{word}")
      elsif search == "backward_match"
        @postfiles = PostFile.where("title LIKE?","%#{word}")
      elsif search == "perfect_match"
        @postfiles = PostFile.where("#{word}")
      elsif search == "partial_match"
        @postfiles = PostFile.where("title LIKE?","%#{word}%")
      else
        @postfiles = PostFile.all
      end
    end
end
