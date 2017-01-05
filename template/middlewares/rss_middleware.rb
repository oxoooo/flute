module RssMiddleware

  def rss_items      
    @rss_body ||= network.get(self.class.opts[:start_urls].first).body
    @rss ||= Feedjira::Feed.parse @rss_body
    @rss_items ||= @rss.entries.select {|item|
      !item.url.blank?
    }.map {|item|
      RssItem.create item
    }
  end

  def items
    rss_items[0..5]
  end
end
