FROM ruby:3.2.2

ENV BUNDLE_PATH=/usr/local/bundle \
    BUNDLE_APP_CONFIG=/usr/local/bundle/config \
    RAILS_ENV=development

WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

EXPOSE 8000

CMD ["bundle", "exec", "rackup", "-o", "0.0.0.0", "-p", "8000"]
