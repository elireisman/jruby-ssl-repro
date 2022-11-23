require "open-uri"

def main
  url = "https://repo1.maven.org/maven2/.index/nexus-maven-repository-index.properties"
  remote_io = open(url, "User-Agent" => "Testing")
  IO.copy_stream(remote_io, STDOUT)
  remote_io.close
end

main
