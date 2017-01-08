FROM johnmccabe/jenkins-slave:latest
MAINTAINER John McCabe <john@johnmccabe.net>

# Install Ruby
RUN apt-get -q update &&\
    DEBIAN_FRONTEND="noninteractive" apt-get -q install -y --no-install-recommends \
        git \
        wget \
        build-essential \
        libssl-dev \
        libreadline-dev \
        ca-certificates \
        zlib1g-dev && \
    git clone https://github.com/rbenv/rbenv.git /home/jenkins/.rbenv && \
    git clone https://github.com/rbenv/ruby-build.git /home/jenkins/.rbenv/plugins/ruby-build && \
    echo 'export PATH=/home/jenkins/.rbenv/bin:$PATH' >> /home/jenkins/.bash_profile && \
    echo 'eval "$(rbenv init -)"' >> /home/jenkins/.bash_profile && \
    echo 'export CONFIGURE_OPTS=--disable-install-doc' >> /home/jenkins/.bash_profile && \
    chown -R jenkins:jenkins /home/jenkins && \
    su - jenkins -c 'rbenv install 2.3.3' && \
    su - jenkins -c 'rbenv global 2.3.3' && \
    su - jenkins -c 'gem install bundler' && \
    apt-get -q clean -y && rm -rf /var/lib/apt/lists/* && rm -f /var/cache/apt/*.bin