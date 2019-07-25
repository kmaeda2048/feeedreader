class FeedsController < ApplicationController
  def index
    @feeds = Feed.all

    # url = "http://b.hatena.ne.jp/hotentry/it.rss"
    # xml = HTTParty.get(url).body
    # @feed = Feedjira.parse(xml)

    # title, url, summary, published, content, サムネイルをどうやって取得するか？
  end

  def show
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
  end

  def update
  end

  def destroy
  end

  private

  def feed_params
    params.require(:feed).permit(:title, :description, :url)
  end
end
