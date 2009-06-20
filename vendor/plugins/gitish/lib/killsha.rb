require 'gdbm'

g = GDBM.new("store-local/blobs.db")

for s in ARGV
  puts "Removing #{s}"
  g.delete s
end
