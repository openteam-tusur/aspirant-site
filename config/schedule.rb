set :output, 'log/cron.log'

every :day, at: '3am' do
  runner 'Rails.cache.cleanup'
end

#every 4.hours do
  #rake 'sitemap:create'
#end
