#!/bin/bash

LAST_CFG=`bin/develop rb -n`
echo $LAST_CFG

# Avoid running buildout on docker start
if [[ "$LAST_CFG" == *base.cfg ]]; then
  if ! test -e $ZOPE_HOME/buildout.cfg; then
      python /configure.py
  fi

  if test -e $ZOPE_HOME/buildout.cfg; then
      $ZOPE_HOME/bin/buildout -c $ZOPE_HOME/buildout.cfg
  fi
fi
