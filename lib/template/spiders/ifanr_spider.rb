class IfanrSpider < Flute::SpiderBase
  include RssMiddleware
  
  set_name 'ifanr'
  start_urls ['http://www.ifanr.com/feed']

  def before_parse(items)
    items.map {|item|
      WebItem.new url: item.url,
                  title: item.title
    }
  end

  def parse(items)
    items.map do |item|
      request = network.request(item.url)
      request.meta = item
      manager.queue request
      request
    end
  end

  def after_parse(requests)
    requests.map {|request|
      html = request.response_html
      item = request.meta
      item.description = html.og_description
      unless html.og_image.blank?
        item.image = html.og_image
      end
      item
    }
  end

end
