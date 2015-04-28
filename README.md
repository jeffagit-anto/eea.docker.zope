##  Zope Server base Docker image

This a base image for Zope Server, it's a generic one so it can be used not only in EEA projects.

### Repository
- [hub.docker.com](https://registry.hub.docker.com/u/eeacms/zope/)

### Projects
- [EEA Glossary](https://github.com/eea/eea.docker.glossary)

### Tags (version of Zope Server)
- latest
- 2.8.0 (with Python 2.3.5, ZLIB 1.2.8, Zope 2.8.0)

### Environment variables
You can create new images by modifying these variables:
 - ZLIB_VERSION
 - PYTHON_VERSION
 - ZOPE_VERSION

### How to use this image
  
  **Create a ZEO instance**
  
    FROM eeacms/zope
    
    ENV STORAGE_PATH /var/local/zeostorage
    RUN python $ZOPE_PATH/bin/mkzeoinstance.py $STORAGE_PATH
    CMD $STORAGE_PATH/bin/zeoctl start && $STORAGE_PATH/bin/zeoctl logtail
    
  **Create a Zclient instance**
    
    FROM eeacms/zope
    ENV ZOPE_INSTANCE /var/local/zclient
    ENV ZOPE_USER zope

    # Add the zope user
    RUN useradd -u 1000 -m -s /bin/bash $ZOPE_USER
    # Create zope instance
    RUN python $ZOPE_PATH/bin/mkzopeinstance.py -d $ZOPE_INSTANCE -u $ZOPE_USER:$ZOPE_USER
    RUN touch $ZOPE_INSTANCE/log/event.log
    # Start Zclient
    USER 1000
    CMD $ZOPE_INSTANCE/bin/zopectl start && $ZOPE_INSTANCE/bin/zopectl logtail
