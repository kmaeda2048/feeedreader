class FeedsController < ApplicationController
  def index
    @feeds = Feed.all

    # url = "http://b.hatena.ne.jp/hotentry/it.rss"
    # xml = HTTParty.get(url).body
    # @feed = Feedjira.parse(xml)

    # title, url, summary, published, content
  end

  def show
    @feed = Feed.find(params[:id])
  end

  def new
    @feed = Feed.new
  end

  def create
    @feed = Feed.new(feed_params)

    if @feed.save
      redirect_to @feed, notice: "「#{@feed.title}」を登録しました。"
    else
      render :new
    end
  end

  def edit
    @feed = Feed.find(params[:id])
  end

  def update
    @feed = Feed.find(params[:id])
    if @feed.update(feed_params)
      redirect_to @feed, notice: "「#{@feed.title}」を更新しました。"
    else
      render :edit
    end
  end

  def destroy
    @feed = Feed.find(params[:id])
    @feed.destroy
    redirect_to feeds_path
  end

  private

  def feed_params
    params.require(:feed).permit(:title, :description, :url)
  end
end
