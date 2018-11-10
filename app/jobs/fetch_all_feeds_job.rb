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

          # Content or summary for Atom 1.0
          content = entry_hash["content"] if entry_hash.key?("content")
          content = entry_hash["summary"] if entry_hash.key?("summary")

          # Description for RSS 2.0
          content = entry_hash["description"] if entry_hash.key?("description")

          db_entry.update_attributes(content: content, author: entry.author, url: entry.url, published: entry.published)
          Sidekiq::Logging.logger.info "Loaded entry: #{entry.title}"
        end
        Sidekiq::Logging.logger.info "Loaded feed: ##{feed.name}"
      end      
    rescue => e
      Sidekiq::Logging.logger.debug e.message
    end
  end

end