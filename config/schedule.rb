set :output, "/tmp/log/cron_log.log"

every :sunday, :at => '12am' do
  runner "Meme.move_to_next_meme", :environment => :development
end


every :sunday, :at => '12am' do
  runner "Archive.archive_winner", :environment => :development
end

every :sunday, :at => '12am' do
  runner "Meme.move_to_next_meme"
end


every :sunday, :at => '12am' do
  runner "Archive.archive_winner"
end

# every 1.minute do
#   runner "Archive.testing", :environment => :production
# end

# every 1.minute do
#   runner "Archive.testing"
# end