#!/bin/bash
#
# god       Startup script for god (http://god.rubyforge.org)
#
# chkconfig: - 85 15
# description: God is an easy to configure, easy to extend monitoring \
#              framework written in Ruby.
#

# Add /usr/local/bin to path so god can find bundler on boot
PATH=$PATH:/usr/local/bin
export PATH

CONF_DIR=/etc/god
GOD_BIN=/usr/local/bin/god
RUBY_BIN=/usr/local/bin/ruby
RETVAL=0

# Go no further if config directory is missing.
[ -d "$CONF_DIR" ] || exit 0

case "$1" in
    start)
      # Create pid directory
      $RUBY_BIN $GOD_BIN -c $CONF_DIR/master.conf
      RETVAL=$?
  ;;
    stop)
      $RUBY_BIN $GOD_BIN terminate
      RETVAL=$?
  ;;
    restart)
      $RUBY_BIN $GOD_BIN terminate
      $RUBY_BIN $GOD_BIN -c $CONF_DIR/master.conf
      RETVAL=$?
  ;;
    status)
      $RUBY_BIN $GOD_BIN status
      RETVAL=$?
  ;;
    *)
      echo "Usage: god {start|stop|restart|status}"
      exit 1
  ;;
esac

exit $RETVAL
