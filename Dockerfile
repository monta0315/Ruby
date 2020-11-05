FROM ruby:2.7

#install node.js
RUN curl -sL https://deb.nodesource.com/setup_14.x |   bash -
RUN apt-get install -y nodejs

#install yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg |  apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" |  tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update
RUN apt-get update &&  apt-get install yarn

#install bundle
RUN mkdir /myapp
WORKDIR /myapp

COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
#lockはより細かいバージョンを保持するもので依存関係などを保つ
RUN bundle install

COPY . /myapp

#localhost:3000で開くため
EXPOSE 3000

CMD ["rails","server","-b","0.0.0.0"]
