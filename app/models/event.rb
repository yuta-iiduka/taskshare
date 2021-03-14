class Event < ApplicationRecord
  belongs_to :user
  has_many :tagmap_events, dependent: :destroy
  has_many :tags, through: :tagmap_events
  
  def save_tag(sent_tags)
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    old_tags = current_tags - sent_tags
    new_tags = sent_tags - current_tags
    
    old_tags.each do |old_name|
      self.tags.delete Tag.find_by(name: old_name)
    end
      
    new_tags.each do |new_name|
      new_events_tag = Tag.find_or_create_by(name: new_name)
      self.tags << new_events_tag
    end
  end
end
