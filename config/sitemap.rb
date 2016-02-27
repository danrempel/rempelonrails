SitemapGenerator::Sitemap.default_host = 'http://www.rempelonrails.com'
SitemapGenerator::Sitemap.create do
  add '/', :changefreq => 'weekly', :priority => 0.9
  add '/contacts/new'   
  add '/posts', :changefreq => 'weekly'
  add '/projects', :changefreq => 'weekly'

  Post.find_each do |post|
  	add post_path(post.slug), lastmod: post.updated_at, :priority => 0.5
  end
SitemapGenerator::Sitemap.ping_search_engines # Not needed if you use the rake tasks
end
