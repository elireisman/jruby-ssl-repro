FROM jruby:9.3.9.0

COPY . .
ENTRYPOINT jruby main.rb
