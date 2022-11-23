FROM jruby:9.3.9.0 AS build

WORKDIR /jruby-ssl-repro
COPY . ./

RUN gem install bundler:2.2.33 ruby-maven:3.3.12 jbundler:0.9.4 warbler:2.0.5
RUN bundle install
RUN jbundle install
RUN lock_jars
RUN warble runnable jar


FROM ubuntu:20.04 AS run

RUN apt update -y && apt install -y vim curl openjdk-17-jre ca-certificates-java
COPY --from=build /jruby-ssl-repro/jruby-ssl-repro.jar ./

ENTRYPOINT ["java", "-jar", "jruby-ssl-repro.jar"]
