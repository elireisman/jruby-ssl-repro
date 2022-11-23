require "open-uri"

def main
  url = "https://repo1.maven.org/maven2/.index/"
  remote_io = open(url, "User-Agent" => "Testing")
  IO.copy_stream(remote_io, STDOUT)
  remote_io.close
end

main
