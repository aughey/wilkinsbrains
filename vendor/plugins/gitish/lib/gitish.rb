# Gitish
require 'segmented_datastore'
require 'blobstore'
require 'datastore'
require 'digest/sha1'

class Gitish
  def self.instance
    @instance ||= BlobStore.new(SegmentedDataStore.new(DataStore,options),options)
  end

  def self.store(data)
    sha = Digest::SHA1.hexdigest(data)
    return sha if instance.has_shas?([sha],false)
    instance.write(data,sha)
  end

  def self.get(key)
    instance.read_sha(key)
  end

  def self.options
    {
      "storedir" => "store-local"
    }
  end
end
