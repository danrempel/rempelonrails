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

  def next
    Post.where("id > ?", id).where(published: true).order(id: :asc).limit(1).first
  end

  def prev
    Post.where("id < ?", id).where(published: true).order(id: :desc).limit(1).first
  end
end
