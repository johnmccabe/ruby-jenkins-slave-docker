if [ "`whoami`" = "jenkins" ]; then
  export PATH=/home/jenkins/.rbenv/bin:$PATH
  eval "$(rbenv init -)"
  export CONFIGURE_OPTS=--disable-install-doc
fi