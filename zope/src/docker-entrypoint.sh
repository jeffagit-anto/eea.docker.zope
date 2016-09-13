#!/bin/bash
set -e

COMMANDS="debug help logtail show stop adduser fg kill quit run wait console foreground logreopen reload shell status"
START="start restart"
CMD="bin/instance"

LAST_CFG=`python /last-built-cfg.py`
# Avoid running buildout on docker start
if [[ "$LAST_CFG" == *base.cfg ]]; then
  if ! test -e $ZOPE_HOME/buildout.cfg; then
      python /configure.py
  fi

  if test -e $ZOPE_HOME/buildout.cfg; then
      ./bin/buildout -c buildout.cfg
  fi
fi

if [[ $START == *"$1"* ]]; then
  echo $DEBUG
  if [ ! -z $DEBUG ]; then
    if [[ $DEBUG == *on* ]]; then
      exec $CMD fg
    fi
  else
    _stop() {
      $CMD stop
      kill -TERM $child 2>/dev/null
    }

    trap _stop SIGTERM SIGINT
    $CMD start
    $CMD logtail &

    child=$!
    wait "$child"
  fi
else
  if [[ $COMMANDS == *"$1"* ]]; then
    exec $CMD "$@"
  fi
  exec "$@"
fi
