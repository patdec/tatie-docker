FROM ruby:1.9.3

RUN apt-get update -qq
RUN apt-get install -y build-essential locales

# for mysql
# RUN apt-get install -y libmysql-dev
RUN apt-get install -y nodejs

# for nokogiri
RUN apt-get install -y libxml2-dev libxslt1-dev

RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
RUN locale-gen
RUN export LANG=en_US.UTF-8
RUN export LC_ALL=en_US.UTF-8

# Set an environment variable where the Rails app is installed to inside of Docker image:
ENV APP_HOME /var/www/blezat
RUN mkdir -p $APP_HOME

# Set working directory, where the commands will be ran:
WORKDIR $APP_HOME

COPY ./blezat/Gemfile Gemfile
COPY ./blezat/Gemfile.lock Gemfile.lock

#ENV BUNDLE_GEMFILE=$APP_HOME/Gemfile
ENV BUNDLE_JOBS=2
ENV BUNDLE_PATH=/usr/local/bundle

RUN gem install bundler
RUN bundle update

# Copy the main application.
COPY ./blezat .

#EXPOSE 3000

#CMD bundle exec rails s -b 0.0.0.0
