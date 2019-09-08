class FeedsController < ApplicationController
  def index
    @feeds = Feed.all
    @page_feeds = Feed.all.page(params[:page])
  end

  def show
    @feeds = Feed.all
    @feed = Feed.find(params[:id])
    @articles = Article.where(feed_id: @feed.id, unread: true)
    @now_page = @feed.title
    @articles_count = @articles.size
  end

  def new
    @feeds = Feed.all
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
    @feeds = Feed.all
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
    params.require(:feed).permit(:title, :feed_url)
  end
end
