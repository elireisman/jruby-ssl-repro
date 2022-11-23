require "jar_dependencies"

Jars.require_jars_lock!

class HttpHandler
  include org.apache.maven.index.reader.ResourceHandler

  def initialize(base)
    @base = java.net.URI.new(base)
  end

  def locate(name)
    HttpResource.new(@base, name)
  end

  def close; end
end

class HttpResource
  include org.apache.maven.index.reader.ResourceHandler::Resource

  def initialize(base, name)
    @base = base
    @name = name
  end

  def read
    target = @base.resolve(@name).toURL

    conn = target.openConnection
    conn.setRequestMethod("GET")
    conn.setRequestProperty("User-Agent", "Testing")

    java.io.BufferedInputStream.new(conn.getInputStream)
  end

  def close; end
end

def main
  url = "https://repo1.maven.org/maven2/.index/"
  #local = FileHandler.new(".")
  remote = HttpHandler.new(url)

  puts "Creating Index Reader..."
  reader = org.apache.maven.index.reader.IndexReader.new(nil, remote)
  puts "ID: #{reader.getIndexId}"
  puts "Timestamp: #{reader.getPublishedTimestamp}"
  puts "Chunk Names: #{reader.getChunkNames}"
  puts
end

main
