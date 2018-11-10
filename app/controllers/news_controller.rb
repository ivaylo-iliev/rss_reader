class NewsController < ApplicationController
  def index
    @news = Feed.joins(:entries).where("entries.published >= #{Date.today - 1.day}").select("feeds.name as feed, entries.title, entries.published, entries.content, entries.url, entries.author").order("entries.published desc")
    @news = @news.paginate(page: params[:page], per_page:  (params[:items].present? ? params[:items] : 20))
  end
end
