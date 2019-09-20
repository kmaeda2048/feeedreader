namespace :article do
  desc '既読記事や古い記事の削除'
  task :destroy => :environment do
    puts "開始時: #{Article.all.size}件"

    Article.where(unread: false).map(&:destroy)
    puts "既読記事の削除後: #{Article.all.size}件"

    max = 1000

    if Article.all.size > max
      (Article.all.size - max).times do
        Article.all.order(published: 'asc').first.destroy
      end
      puts "古い記事の削除後: #{Article.all.size}件"
    end
  end
end
