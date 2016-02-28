class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :prepare_meta_tags, if: "request.get?"

  def prepare_meta_tags(options={})
    site_name = "Rempel on Rails"
    title = [controller_name.capitalize, action_name.capitalize].join(" ")
    author = "Dan Rempel"
    description = "Rempel on Rails is a blog for beginner and intermediate Ruby and Rails developers, as well as a personal Rails portfolio for Dan Rempel."
    image = options[:image] || ""
    current_url = request.url

    # Defaults
    defaults = {
      site: site_name,
      title: title,
      author: author,
      image: image,
      description: description,
      keywords: %w[web development ruby rails],
      og: {
        url: current_url,
        site_name: site_name,
        title: title,
        image: image,
        description: description,
        type: 'website'
      }
    }

    options.reverse_merge!(defaults)

    set_meta_tags options
  end
end
