class PostFile < ApplicationRecord
    has_many_attached :files
    belongs_to :user
    has_many :post_comments, dependent: :destroy
    has_many :favorites, dependent: :destroy
    has_many :favorited_users, through: :favorites, source: :user
    has_many :post_commented_users, through: :post_comments, source: :user
    has_many :tagmap_postfiles, dependent: :destroy
    has_many :tags, through: :tagmap_postfiles
    
    def favorited_by?(user)
      favorites.where(user_id: user.id).exists?
    end
    
    #検索機能
    def self.search(search,word,sortstyle)
      if search == "forward_match"
        @postfiles = PostFile.where("title LIKE?","#{word}%")
      elsif search == "backward_match"
        @postfiles = PostFile.where("title LIKE?","%#{word}")
      elsif search == "perfect_match"
        @postfiles = PostFile.where("title LIKE?","#{word}")
      elsif search == "partial_match"
        @postfiles = PostFile.where("title LIKE?","%#{word}%")
      else
        @postfiles = PostFile.all
      end
      if sortstyle == "favorite"
        @postfiles = @postfiles.includes(:favorited_users).sort {|a,b| b.favorited_users.size <=> a.favorited_users.size}
      elsif sortstyle == "nonfavorite"
        @postfiles = @postfiles.includes(:favorited_users).sort {|a,b| b.favorited_users.size <=> a.favorited_users.size}.reverse
      elsif sortstyle == "new"
        @postfiles = @postfiles.sort {|a,b| b.updated_at <=> a.updated_at}
      elsif sortstyle == "old"
        @postfiles = @postfiles.sort {|a,b| b.updated_at <=> a.updated_at}.reverse
      elsif sortstyle == "comments"
        @postfiles = @postfiles.includes(:post_commented_users).sort {|a,b| b.post_commented_users.size <=> a.post_commented_users.size}
      elsif sortstyle == "no-comments"
        @postfiles = @postfiles.includes(:post_commented_users).sort {|a,b| b.post_commented_users.size <=> a.post_commented_users.size}.reverse
      end
    end
    
    #タグ保存機能
    def save_tags(save_post_file_tags)
      current_tags = self.tags.pluck(:name) unless self.tags.nil?
      old_tags = current_tags - save_post_file_tags
      new_tags = save_post_file_tags - current_tags
      
      old_tags.each do |old_name|
        self.tags.delete Tag.find_by(name: old_name)
      end
      
      new_tags.each do |new_name|
        new_post_file_tag = Tag.find_or_create_by(name: new_name)
        self.tags << new_post_file_tag
      end
    end
end
