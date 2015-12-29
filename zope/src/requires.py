#!/usr/bin/python
""" Find and create requires.yum and requires.apt
"""
import sys

def main(path):

    yum_section = False
    yum = set()

    apt_section = False
    apt = set()

    with open(path, 'r') as ofile:
        lines = ofile.readlines()

        for line in lines:
            line = line.strip()

            if not line:
                continue

            if line.startswith('['):
                if '[yum]' in line:
                    yum_section = True
                else:
                    yum_section = False

                if '[apt]' in line:
                    apt_section = True
                else:
                    apt_section = False
                continue

            if yum_section:
                yum.add(line)
                continue

            if apt_section:
                apt.add(line)
                continue

    if yum:
        yum_path = path.replace('.txt', '.yum')
        print "Adding yum requirements to %s" % yum_path
        with open(yum_path, 'w') as ofile:
            ofile.write('\n'.join(yum))

    if apt:
        apt_path = path.replace('.txt', '.apt')
        print "Adding apt requirements to %s" % apt_path
        with open(apt_path, 'w') as ofile:
            ofile.writelines('\n'.join(apt))

if __name__=="__main__":
    path = sys.argv[1]
    main(path)
