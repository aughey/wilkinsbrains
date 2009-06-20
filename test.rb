require 'config/environment'
require 'find'

storage = Gitish

for dir in ARGV
  Find.find(dir) do |path|
    if File.file?(path)
      puts path
      begin
        File.open(path) do |file|
          tostore = file.read
          sha = storage.store(tostore)
          data = storage.get(sha)
          raise "Didn't get what I asked" unless data == tostore
        end
      rescue Exception => e
        puts "Couldn't open #{path}: #{e}"
      end
    end
  end
end

storage.sync
