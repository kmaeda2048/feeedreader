class FeedsController < ApplicationController
  def index
    @feeds = Feed.all
    @q = Feed.ransack(params[:q])
    @page_feeds = @q.result(distinct: true).page(params[:page])
  end

  def show
    @feeds = Feed.all
    @feed = Feed.find(params[:id])
    @articles = Article.where(feed_id: @feed.id, unread: true)
    @now_page = @feed.name
    @articles_count = @articles.size
  end

  def new
    @feeds = Feed.all
    @feed = Feed.new
  end

  def create
    @feeds = Feed.all
    @feed = Feed.new(feed_params)

    if @feed.save
      redirect_to @feed, notice: "「#{@feed.name}」を登録しました。"
    else
      render :new
    end
  end

  def edit
    @feeds = Feed.all
    @feed = Feed.find(params[:id])
  end

  def update
    @feed = Feed.find(params[:id])
    if @feed.update(feed_params)
      redirect_to @feed, notice: "「#{@feed.name}」を更新しました。"
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
