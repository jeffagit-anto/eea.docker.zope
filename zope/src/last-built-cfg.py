#!/usr/bin/python
""" Retrieve the last ran buildout config by parsing .mr.developer.cfg file
"""
import ConfigParser
import os
ZOPE_HOME = os.environ.get('ZOPE_HOME', '/opt/zope')
MRDEV_PATH = os.path.join(ZOPE_HOME, '.mr.developer.cfg')


def main():
    cfg = ConfigParser.ConfigParser()
    b_cfg = 'buildout.cfg'

    if cfg.read(MRDEV_PATH):
        if 'buildout' in cfg.sections():
            if 'args' in cfg.options('buildout'):
                args = cfg.get('buildout', 'args')
                args = "".join(args.split("'")).split('\n')
                cfg_args = [args[args.index(arg) + 1] for arg in args
                            if arg == '-c']
                if cfg_args:
                    b_cfg = cfg_args[-1]
    print b_cfg


if __name__ == "__main__":
    main()
