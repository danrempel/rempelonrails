xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Rempel on Rails"
    xml.author "Dan Rempel"
    xml.description "A blog for beginner and intermediate Ruby and Rails developers."
    xml.link "http://www.rempelonrails.com"
    xml.language "en"
    
    for post in @posts
      xml.item do
        xml.title post.title
        xml.author "Dan Rempel"
        xml.description post.content
        xml.pubDate post.created_at.to_s(:rfc822)
        xml.link post_url(post)
        xml.guid post_url(post)
      end
    end
  end
end