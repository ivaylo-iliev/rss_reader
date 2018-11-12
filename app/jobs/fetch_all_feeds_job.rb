class FetchAllFeedsJob < ApplicationJob
  queue_as :default

  def perform(*args)
    begin
      # Read all feeds saved in the application
      Feed.all.each do |feed|
        # Get the current content of the feed
        content = Feedjira::Feed.fetch_and_parse feed.url

        # Loop through the content of the feed and insert it int he entries table
        content.entries.each do |entry|
          entry_hash = entry.to_h
          db_entry = feed.entries.where(title: entry["title"]).first_or_initialize

          db_entry.update_attributes(author: entry.author, url: entry.url, published: entry.published)
        end
      end
    rescue => e
      Sidekiq::Logging.logger.debug e.message
    end
  end

end
