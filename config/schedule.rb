set :output, "/Users/rickmitchell/WebDev/memr/log/cron_log.log"
# Add to crontab: SHELL=/bin/bash
# every :sunday, :at => '12am' do
#   runner "Meme.move_to_next_meme", :environment => :development
# end


# every :sunday, :at => '12am' do
#   runner "Archive.archive_winner", :environment => :development
# end

# Change Weekly Meme Image: Production
every :sunday, :at => '12am' do
  runner "Meme.move_to_next_meme", :environment => :production
end

# Archive Winner Meme End of Week: Production
every :sunday, :at => '12am' do
  runner "Archive.archive_winner", :environment => :production
end

# Test Print to cron_log.log : Production
every 1.minute do
  runner "Meme.get_info", :environment => :production
end

# Archive Winner Meme End of Week: Production Every Minute
every 1.minute do
  runner "Archive.archive_winner", :environment => :production
end