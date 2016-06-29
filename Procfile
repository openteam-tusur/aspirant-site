profile:        sh -c 'cd $PROFILE_PATH && bundle exec rails s -p $PROFILE_PORT'

tusur:          sh -c 'cd $TUSUR_PATH && bundle exec rails s -p $TUSUR_PORT'
sidekiq:        sh -c 'cd $TUSUR_PATH && bundle exec sidekiq -C config/sidekiq.yml'

redis:          redis-server $REDIS_CONFIG
