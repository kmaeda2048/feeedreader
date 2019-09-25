class FeedsController < ApplicationController
  def index
    @side_feeds = Feed.all
    @q = Feed.ransack(params[:q])
    @feeds = @q.result(distinct: true).recently
  end

  def unread
    @side_feeds = Feed.all
    @feed = Feed.find(params[:id])
    @q = Article.where(feed_id: @feed.id).unread.ransack(params[:q])
    @articles = @q.result(distinct: true).order_pub
    @now_page = @feed.name
    @articles_count = @articles.size
  end

  def new
    @side_feeds = Feed.all
    @feed = Feed.new
  end

  def create
    @side_feeds = Feed.all
    @feed = Feed.new(feed_params)

    if @feed.save
      redirect_to unread_feed_path(@feed), notice: "「#{@feed.name}」を登録しました。"
    else
      render :new
    end
  end

  def edit
    @side_feeds = Feed.all
    @feed = Feed.find(params[:id])
  end

  def update
    @feed = Feed.find(params[:id])
    if @feed.update(feed_params)
      redirect_to unread_feed_path(@feed), notice: "「#{@feed.name}」に更新しました。"
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
    params.require(:feed).permit(:name, :feed_url)
  end
end
