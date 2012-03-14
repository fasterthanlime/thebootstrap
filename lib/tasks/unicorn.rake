
namespace :unicorn do
    UNICORN_CONFIG="#{Rails.root}/config/unicorn.rb"
    PID_FILE="#{Rails.root}/tmp/pid/unicorn.pid"

    task :start => :environment do
        `bundle exec unicorn_rails -c #{UNICORN_CONFIG} -D -E production` 
        puts "Started unicorn"
    end

    task :reload => :environment do
        `kill -s USR2 $(cat #{PID_FILE})`
        puts "Reloaded unicorn"
    end

    task :stop => :environment do
        `kill $(cat #{PID_FILE})`
        puts "Stopped unicorn"
    end

end
