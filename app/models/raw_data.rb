require 'digest/sha1'
require 'fileutils'

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
