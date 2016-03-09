class Post < ActiveRecord::Base
  acts_as_taggable_on :tags
	extend FriendlyId
  friendly_id :title, use: :slugged

  def should_generate_new_friendly_id?
    new_record?
  end
  
  def self.search(query)
    where("title like ? OR subtitle like ? OR content like ?", "%#{query}%", "%#{query}%", "%#{query}%")
  end
end
