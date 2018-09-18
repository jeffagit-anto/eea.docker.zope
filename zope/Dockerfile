FROM python:2.7-slim-stretch
MAINTAINER "Alin Voinea" <alin.voinea@eaudeweb.ro>

ENV PIP=9.0.3 \
    ZC_BUILDOUT=2.11.2 \
    SETUPTOOLS=38.7.0 \
    PYTHON=python \
    CONFIG=base.cfg \
    ZOPE_HOME=/opt/zope

RUN mkdir -p $ZOPE_HOME/var &&  \
    groupadd -g 500 zope-www && \
    useradd  -g 500 -u 500 -m -s /bin/bash zope-www && \
    chown -R 500:500 $ZOPE_HOME

COPY src/docker-entrypoint.sh    \
     src/zope-setup.sh           \
     src/configure.py            \
     src/last-built-cfg.py       /

COPY src/versions.cfg            \
     src/sources.cfg             \
     src/zope.cfg                \
     src/base.cfg                \
     src/install.sh              $ZOPE_HOME/

RUN buildDeps="dpkg-dev gcc libbz2-dev libc6-dev libjpeg62-turbo-dev libopenjp2-7-dev libpcre3-dev libssl-dev libtiff5-dev libxml2-dev libxslt1-dev wget zlib1g-dev" \
 && runDeps="gosu libjpeg62 libopenjp2-7 libtiff5 libxml2 libxslt1.1 lynx netcat poppler-utils rsync wv" \
 && apt-get update \
 && apt-get install -y --no-install-recommends $buildDeps \
 && pip install pip==$PIP setuptools==$SETUPTOOLS zc.buildout==$ZC_BUILDOUT \
 && cd $ZOPE_HOME && ./install.sh \
 && apt-get purge -y --auto-remove $buildDeps \
 && apt-get install -y --no-install-recommends $runDeps \
 && rm -rf /var/lib/apt/lists/*

EXPOSE 8080

WORKDIR $ZOPE_HOME

HEALTHCHECK --interval=1m --timeout=5s --start-period=1m \
  CMD nc -z -w5 127.0.0.1 8080 || exit 1

USER zope-www

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["start"]
