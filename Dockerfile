FROM ruby:alpine
RUN gem install redis
ADD ./redis-trib.rb ./redis-trib.rb