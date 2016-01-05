#!/bin/bash
DEPATH=$1
find $DEPATH -name "requires.txt" -exec python /requires.py {} \;
