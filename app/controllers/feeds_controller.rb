class FeedsController < ApplicationController
  before_action :set_feed, only: [:show, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token

  # GET /feeds
  # GET /feeds.json
  def index
    @feeds = Feed.all
    if params[:reload_single].present?
      FetchFeedJob.set(wait_until: Time.now + 1.seconds).perform_later(params[:reload_single])
      feed = Feed.where(id: params[:reload_single]).first
      redirect_to feeds_path, notice: "Feed #{feed.name} was successfully updated."
    end

    if params[:reload_all].present?
      FetchAllFeedsJob.set(wait_until: Time.now + 1.seconds).perform_later()
      redirect_to feeds_path, notice: "All feeds were successfully updated."
    end
  end

  def generate
    if params[:id].present?
      FetchFeedJob.set(wait_until: Time.now + 1.seconds).perform_later(params[:id])
    else
      FetchAllFeedsJob.set(wait_until: Time.now + 1.seconds).perform_later()
    end
    redirect_to feeds_path, notice: "Feed update was triggered."
  end

  # GET /feeds/1
  # GET /feeds/1.json
  def show
  end

  # GET /feeds/new
  def new
    @feed = Feed.new
  end

  # GET /feeds/1/edit
  def edit
  end

  # POST /feeds
  # POST /feeds.json
  def create
    @feed = Feed.new(feed_params)

    respond_to do |format|
      if @feed.save
        FetchFeedJob.set(wait_until: Time.now + 1.seconds).perform_later(@feed.id)
        format.html { redirect_to feeds_path, notice: 'Feed was successfully created.' }
        format.json { render :show, status: :created, location: @feed }
      else
        format.html { render :new }
        format.json { render json: @feed.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /feeds/1
  # PATCH/PUT /feeds/1.json
  def update
    respond_to do |format|
      if @feed.update(feed_params)
        format.html { redirect_to @feed, notice: 'Feed was successfully updated.' }
        format.json { render :show, status: :ok, location: @feed }
      else
        format.html { render :edit }
        format.json { render json: @feed.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /feeds/1
  # DELETE /feeds/1.json
  def destroy
    @feed.destroy
    respond_to do |format|
      format.html { redirect_to feeds_url, notice: 'Feed was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_feed
      @feed = Feed.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def feed_params
      params.require(:feed).permit(:name, :url, :description)
    end
end
