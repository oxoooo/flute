module Flute
  class Document < Nokogiri::HTML::Document
    def og_title
      og('title')
    end

    def og_description
      og('description')
    end

    def og_image
      og('image')
    end

    def og_site_name
      og('site_name')
    end

    def description
      self.css('meta[name="description"]')&.first&.attr('content')&.strip
    end

    def og(name)
      self.css("meta[property='og:#{name}']")&.first&.attr('content')
    end

  end
end