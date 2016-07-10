FROM ruby:2.2.1
MAINTAINER Karthik Krishnan <me@karthiks.in>

RUN apt-get update && \
    apt-get install -y net-tools

# Install gems
ENV APP_HOME /app
ENV HOME /root
RUN mkdir $APP_HOME
WORKDIR $APP_HOME
#ADD https://www.random.org/strings/?num=1&len=16&digits=on&upperalpha=on&loweralpha=on&unique=on&format=plain&rnd=new $APP_HOME/cachebuster
COPY Gemfile* $APP_HOME/
RUN bundle install

# Upload source
COPY . $APP_HOME

# Start server
ENV PORT 3000
EXPOSE 3000
CMD ["rackup", "-o", "0.0.0.0", "-p", "3000"]
