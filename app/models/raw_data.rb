require 'digest/sha1'
require 'fileutils'

# RawData acts like a basic key => value system that operates like git does
# with respect to taking a SHA hash of the data and writing it to storage.
# This is designed to write it to a directory of files, with the anticipation
# that another sweeper will come around and garbage collect these files to
# a more permemant and compressed storage system.
class RawData
  def self.path
    "rawstore"
  end

  def self.get(sha)
    data = nil
    shalock(sha) do |fullpath|
      if File.exists?(fullpath)
        File.open(fullpath,"r") do |file|
          data = file.read
        end
      end
    end
    data
  end

  def self.store(data)
    sha = Digest::SHA1.hexdigest(data)

    shalock(sha) do |fullpath|
      unless File.exists?(fullpath)
        File.open(fullpath,"wb") do |file|
          file.write(data)
        end
      end
    end
    return sha
  end

  def self.shalock(sha)
    dir1 = sha[0,2]
    dir2 = sha[2,2]
    dirpath = "#{path}/#{dir1}/#{dir2}"
    FileUtils.mkdir_p(dirpath) 

    fullpath = "#{dirpath}/#{sha}"
    lock(dirpath) do
      yield fullpath
    end
  end

  def self.lock(dir)
    File.open(dir + "/LOCKFILE","a+") do |file|
      raise "didn't open lock file" unless file
      file.flock File::LOCK_EX
      yield file
      file.flock File::LOCK_UN
    end
  end
end
