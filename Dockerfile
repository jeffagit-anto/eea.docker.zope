FROM eeacms/centos:7
MAINTAINER "Alin Voinea" <alin.voinea@eaudeweb.ro>

ENV PYTHON python
ENV CONFIG base.cfg
ENV SETUPTOOLS 7.0
ENV ZCBUILDOUT 2.2.1
ENV ZOPE_HOME /opt/zope

RUN mkdir -p $ZOPE_HOME/var && \
    groupadd -g 500 zope-www && \
    useradd  -g 500 -u 500 -m -s /bin/bash zope-www && \
    chown -R 500:500 $ZOPE_HOME

COPY src/start.sh           /usr/bin/start
COPY src/configure.py       /configure.py
COPY src/versions.cfg       $ZOPE_HOME/
COPY src/sources.cfg        $ZOPE_HOME/
COPY src/zope.cfg           $ZOPE_HOME/
COPY src/base.cfg           $ZOPE_HOME/
COPY src/bootstrap.py       $ZOPE_HOME/
COPY src/install.sh         $ZOPE_HOME/

WORKDIR $ZOPE_HOME
RUN ./install.sh
VOLUME $ZOPE_HOME/var/

CMD ["start"]
