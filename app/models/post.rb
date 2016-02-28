class Post < ActiveRecord::Base
  acts_as_taggable_on :tags
	extend FriendlyId
  friendly_id :title, use: :slugged
end
