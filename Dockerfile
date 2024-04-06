# Setup ruby
FROM ruby:3.1.2

RUN apt-get update -qq --fix-missing \
  && apt-get install -y --no-install-recommends build-essential libv8-dev nodejs \
    automake pkg-config libtool libffi-dev libssl-dev libgmp-dev python-dev \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN sudo apt-get install ruby-dev
RUN sudo apt-get install zlib1g-de
# Set ENV
ARG RAILS_ENV
ENV RAILS_ENV ${RAILS_ENV:-production}

RUN mkdir -p /app
WORKDIR /app

# Needed for ExecJS
RUN curl -sL https://deb.nodesource.com/setup_16.x | bash -
RUN apt-get install -y nodejs

# Install gems
COPY Gemfile Gemfile.lock ./
RUN bundle config set without 'development test' && gem install bundler -v 2.1.4 && bundle install --retry 5
RUN bundle exec rails assets:precompile

# Copy the main application.
COPY . ./

# Start server
EXPOSE 80
CMD ["bundle", "exec", "puma", "-p", "80"]
