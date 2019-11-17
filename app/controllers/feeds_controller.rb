class FeedsController < ApplicationController
  def index
    @side_feeds = current_user.feeds.recently
    @q = current_user.feeds.ransack(params[:q])
    @feeds = @q.result(distinct: true).recently
  end

  def unread
    @side_feeds = current_user.feeds.recently
    @feed = current_user.feeds.find(params[:id])
    @q = @feed.articles.unread.ransack(params[:q])
    @articles = @q.result(distinct: true).formerly
    @now_page = @feed.name
    @articles_count = @articles.size
  end

  def new
    @side_feeds = current_user.feeds.recently
    @feed = Feed.new
  end

  def create
    @side_feeds = current_user.feeds.recently
    @feed = current_user.feeds.new(feed_params)

    if @feed.save
      redirect_to unread_feed_path(@feed), notice: "登録完了: #{@feed.name}"
    else
      render :new
    end
  end

  def edit
    @side_feeds = current_user.feeds.recently
    @feed = current_user.feeds.find(params[:id])
  end

  def update
    @feed = current_user.feeds.find(params[:id])

    if @feed.update(feed_params)
      redirect_to unread_feed_path(@feed), notice: "更新完了: #{@feed.name}"
    else
      render :edit
    end
  end

  def destroy
    @feed = current_user.feeds.find(params[:id])
    @feed.destroy
    redirect_to feeds_path
  end

  private

  def feed_params
    params.require(:feed).permit(:name, :feed_url)
  end
end
