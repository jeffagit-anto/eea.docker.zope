#!/bin/bash
set -e

COMMANDS="debug help logtail show stop adduser fg kill quit run wait console foreground logreopen reload shell status"
START="start restart"
CMD="bin/instance"
SETUPCMD="/zope-setup.sh"

$SETUPCMD

if [[ $START == *"$1"* ]]; then
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
