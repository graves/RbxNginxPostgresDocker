FROM ubuntu:precise
MAINTAINER Thomas Graves <thomas@ooo.pm> 

ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8
ENV SHELL /bin/bash
ENV DEBIAN_FRONTEND noninteractive

# Add repos
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y -q python-software-properties
RUN add-apt-repository ppa:chris-lea/node.js
RUN echo "deb http://us.archive.ubuntu.com/ubuntu/ precise universe" >> /etc/apt/sources.list
RUN apt-get update
RUN apt-get install -y nodejs

# Install dependencies
# RUN apt-get install -y -q build-essential openssl libreadline6 libreadline6-dev curl git-core zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt-dev autoconf libc6-dev ncurses-dev automake libtool bison subversion pkg-config libmysqlclient-dev libpq-dev make wget unzip git vim nano nodejs mysql-client mysql-server gawk libgdbm-dev libffi-dev
RUN apt-get install -y wget make
RUN apt-get install -y git gcc g++ automake flex bison ruby1.9.1-dev llvm-dev zlib1g-dev libyaml-dev libssl-dev libgdbm-dev libreadline-dev libncurses5-dev nodejs
RUN apt-get install -y -q ca-certificates

# Install ruby-install
RUN mkdir /tmp/ruby-install ;\

# Install chruby
RUN mkdir /tmp/chruby ;\
    wget -O chruby-0.3.8.tar.gz https://github.com/postmodern/chruby/archive/v0.3.8.tar.gz ;\
    tar -xzvf chruby-0.3.8.tar.gz ;\
    cd chruby-0.3.8/ && make install ;\
    rm -rf /tmp/chruby

RUN echo '[ -n "$BASH_VERSION" ] || [ -n "$ZSH_VERSION" ] || return' >> /etc/profile.d/chruby.sh
RUN echo 'source /usr/local/share/chruby/chruby.sh' >> /etc/profile.d/chruby.sh
RUN echo 'source /usr/local/share/chruby/auto.sh' >> $HOME/.bashrc

# Install Rubinius 2.2.6
RUN locale-gen en_US.UTF-8
RUN update-locale LANG=en_US.UTF-8
RUN export LC_ALL=en_US.UTF-8
RUN echo "export LC_ALL=en_US.UTF-8" >> /etc/environment
RUN export PATH=/usr/local/ruby/bin:$PATH
ENV REALLY_GEM_UPDATE_SYSTEM true
RUN gem update --system

RUN gem install bundler
RUN apt-get install -y bzip2 curl
RUN mkdir /tmp/rbx ;\
    cd /tmp/rbx ;\
    wget -O rubinius-release-2.2.10.tar.bz2 http://releases.rubini.us/rubinius-2.2.10.tar.bz2 ;\
    tar -jxf rubinius-release-2.2.10.tar.bz2 ;\
    cd rubinius-2.2.10 ;\
    bundle && ./configure --prefix=/opt/rubies/rubinius-2.2.10 && rake build && rake install

ENV PATH /opt/rubies/rubinius-2.2.10/bin/:/opt/rubies/rubinius-2.2.10/gems/bin/:$PATH

# Install Rubinius and Bundler - Broken right now
#RUN ruby-install rbx ;\
#    chruby rbx ;\
#    gem install bundler --no-ri --no-rdoc

RUN echo 'chruby rbx' >> $HOME/.bash_profile
RUN apt-get install -y libpq-dev
# Preinstall majority of gems
ADD SampleApp/Gemfile /tmp/Gemfile
ADD SampleApp/Gemfile.lock /tmp/Gemfile.lock
RUN cd /tmp ;\
    bundle install

RUN mkdir /tmp/sockets
VOLUME ["/tmp", "/var/www"]

ADD start-server.sh .
RUN chmod u+x start-server.sh

CMD ["./start-server.sh"]
