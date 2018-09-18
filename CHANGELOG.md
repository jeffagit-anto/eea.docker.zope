# Changelog

## 2018-09-18

- Added Zope 2.13.28 version
- Re-based to python:2.7-slim-stretch

## 2016-09-14

- Removed chaperone process manager and added a docker-entrypoint script
- The zope instance can now be started in foreground with: `docker run eeacms/zope fg` or,
  for backwards compatibility, use `DEBUG=on` env

## 2016-01-24

- Possibility to start zope in foreground (`fg`) by setting `DEBUG=on` env

## 2016-01-04

- Start Zope on port *8080* instead of *80*

- Start all processes with *zope-www* user instead of *root*

- Added chaperone process manager


## 2015-11-25

- Added possibility to easily define system dependencies within a Python egg
  by simply adding a file called *requires.yum* within each Python egg.

- Added Zope 2.13.23 version

## 2015-09-29

- Added Zope 2.13.22 version

## 2015-04-27

- Added Zope 2.8.0 version
