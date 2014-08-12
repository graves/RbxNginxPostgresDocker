FROM ubuntu:precise
MAINTAINER Thomas Graves <thomas@ooo.pm> 

ENV DEBIAN_FRONTEND noninteractive

# Add repos
RUN apt-get -y update
RUN apt-get install -y -q python-software-properties
RUN add-apt-repository -y "deb http://archive.ubuntu.com/ubuntu $(lsb_release -sc) universe"
RUN add-apt-repository -y ppa:chris-lea/node.js
RUN apt-get -y update

# Install dependencies
RUN apt-get install -y -q build-essential openssl libreadline6 libreadline6-dev curl git-core zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt-dev autoconf libc6-dev ncurses-dev automake libtool bison subversion pkg-config libmysqlclient-dev libpq-dev make wget unzip git vim nano nodejs mysql-client mysql-server gawk libgdbm-dev libffi-dev
RUN apt-get install -y -q ca-certificates

# Install ruby-install
RUN mkdir /tmp/ruby-install ;\
    cd /tmp/ruby-install ;\
    wget -O ruby-install-0.4.3.tar.gz https://github.com/postmodern/ruby-install/archive/v0.4.3.tar.gz ;\
    tar -xzvf ruby-install-0.4.3.tar.gz ;\
    cd ruby-install-0.4.3/ && make install ;\
    rm -rf /tmp/ruby-install

# Install chruby
RUN mkdir /tmp/chruby ;\
    wget -O chruby-0.3.8.tar.gz https://github.com/postmodern/chruby/archive/v0.3.8.tar.gz ;\
    tar -xzvf chruby-0.3.8.tar.gz ;\
    cd chruby-0.3.8/ && make install ;\
    rm -rf /tmp/chruby

RUN echo '[ -n "$BASH_VERSION" ] || [ -n "$ZSH_VERSION" ] || return' >> /etc/profile.d/chruby.sh
RUN echo 'source /usr/local/share/chruby/chruby.sh' >> /etc/profile.d/chruby.sh
RUN echo 'source /usr/local/share/chruby/auto.sh' >> $HOME/.bashrc

# Install Rubinius and Bundler
RUN ruby-install rbx ;\
    chruby rbx ;\
    gem install bundler --no-ri --no-rdoc

RUN echo 'chruby rbx' >> $HOME/.bash_profile

# Preinstall majority of gems
ADD SampleApp/Gemfile /tmp/Gemfile
ADD SampleApp/Gemfile.lock /tmp/Gemfile.lock
RUN cd /tmp ;\
    bundle install

RUN mkdir /tmp/sockets
VOLUME ["/tmp", "/var/www"]

ADD start_server.sh .
RUN chmod u+x start_server.sh

CMD ["./start_server.sh"]
