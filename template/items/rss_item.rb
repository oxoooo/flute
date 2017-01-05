class RssItem < BaseItem
  attribute :title, String
  attribute :summary, String
  attribute :created, Integer
  attribute :content, String
  attribute :seed_id, Integer
  attribute :head_name, String
  attribute :head_icon, String, default: 'link'

  def self.create(rss_item)
    RssItem.new title: rss_item.title&.squish,
                url: rss_item.url,
                summary: rss_item.summary&.squish,
                content: rss_item.content&.squish,
                created: rss_item.published.to_i
  end
end