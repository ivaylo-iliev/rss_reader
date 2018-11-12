class NewsController < ApplicationController
  # Extract information for for the construction of the aggregated news
  # feed page and its filtering form
  def index
    @feed_list = Feed.distinct(:name).select(:id, :name)
    @news = Feed.joins(:entries).select("feeds.name as feed, entries.*").order("entries.published desc")
		@news = @news.where("feeds.name like '#{params[:feed]}'") if params[:feed].present?
		@news = @news.where("entries.title like '#{params[:title]}'") if params[:title].present?
		@news = @news.where("entries.author like '#{params[:author]}'") if params[:author].present?
		@news = @news.where("entries.published >= '#{params[:timestamp_from]}'") if params[:timestamp_from].present?
		@news = @news.where("entries.published <= '#{params[:timestamp_to]}'") if params[:timestamp_to].present?
    @news = @news.paginate(page: params[:page], per_page:  (params[:items].present? ? params[:items] : 20))
  end
end
