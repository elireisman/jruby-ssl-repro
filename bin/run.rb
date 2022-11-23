require "open-uri"
require "jar_dependencies"

Jars.require_jars_lock!


class Handler < org.apache.maven.index.reader.ResourceHandler
  def initialize(url)
    @url = url
    @data = open(@url, "User-Agent" => "Testing")
  end

  def read()
    @stream if defined?(@stream)
    @stream = java.io.ByteArrayInputStream.new(@data.to_bytes)
  end

  def close()
    @stream.close
  end
end

def main
  url = "https://repo1.maven.org/maven2/.index/nexus-maven-repository-index.properties"
  rs = ::Resource.new(url)
  props = org.apache.maven.index.reader.Utils.loadProperties(rs.read)
  File.open("./nexus-maven-repository-index.properties", "w") do |f|
    org.apache.maven.index.reader.Utils.storeProperties(f.to_outputstream, props)
  end

  remote = org.apache.maven.index.reader.HttpResourceHandler.new(url)
  reader = org.apache.maven.index.reader.IndexReader.new(nil, remote)
end

main
