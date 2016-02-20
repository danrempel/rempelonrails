require 'rubygems'
require 'sitemap_generator'

SitemapGenerator::Sitemap.default_host = 'http://www.rempelonrails.com'
SitemapGenerator::Sitemap.public_path = 'tmp/sitemaps/'

SitemapGenerator::Sitemap.create do
  add root_path, :changefreq => 'weekly', :priority => 0.9
  add new_contact_path
  add posts_path, :changefreq => 'weekly'
  add projects_path, :changefreq => 'weekly'

  Post.find_each do |post|
  	add post_path(post.slug), lastmod: post.updated_at
  end

end
SitemapGenerator::Sitemap.ping_search_engines # Not needed if you use the rake tasks