bundle exec sidekiq -d -e development -v -L ./log/sidekiq-development.log -C ./config/sidekiq.yml
rails s
