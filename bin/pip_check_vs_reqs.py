#!/usr/bin/env python

from __future__ import absolute_import, division, print_function

import argparse
import pip
import pkg_resources
import re

from pip._internal.download import PipSession
from pip._internal.req import parse_requirements
from pkg_resources import DistributionNotFound, VersionConflict


def package_name_from_depstring(dep):
  """
  Takes dependency string of the form "foo==x.y.z", and returns the package name. E.g., "foo"
  """
  matches = re.match('([\w\-]+)[>=<]+', dep)
  if matches is None:
    return None
  pkgname = matches.group(1)
  return pkgname


def find_package_in_dependencies(deps, package):
  # Yes I know this is not very pythonic
  for i, dep in enumerate(deps):
    deppkg = package_name_from_depstring(dep)
    if package == deppkg:
      return i
  return None


# This code is based on https://github.com/pypa/pip/issues/2733
def check_dependencies(requirement_file_name):
    """
    Checks to see if the python dependencies are fullfilled.
    If check passes return 0. Otherwise print error and return 1
    """
    dependencies = []
    session = PipSession()
    for req in parse_requirements(requirement_file_name, session=session):
        if req.req is not None:
            dependencies.append(str(req.req))
        else:
            # The req probably refers to a url. Depending on the
            # format req.link.url may be able to be parsed to find the
            # required package.
            pass

    errs = 0

    # Iterate trying to see if all dependencies are satisfied.  If one is not, print a message
    # and remove it from the set.
    while True:
      try:
          pkg_resources.working_set.require(dependencies)
          break
      except VersionConflict as e:
          try:
              print("{} was found on your system, "
                    "but {} is required.\n".format(e.dist, e.req))
              errs += 1
              reqstr = e.req.__str__()
              if reqstr in dependencies:
                # print("Removing {}".format(reqstr))
                dependencies.remove(e.req.__str__())
                continue
              else:
                # If we get here, then this requirement wasn't explicitly in the list of dependencies.
                # I.e., it is a requirement of one of the packages that is in the list.
                requirers = e.required_by
                print("{} is required by the following packages {}.".format(e.req, requirers))
                print("I can't check whether your package setup is consistent with their other dependencies until " +
                      "you resolve this one by actually installing {}.".format(package_name_from_depstring(reqstr)))
                for requirer in requirers:
                  idx = find_package_in_dependencies(dependencies, requirer)
                  dependencies.pop(idx)
                continue
          except AttributeError:
            print(e)
            errs += 1
            continue
      except DistributionNotFound as e:
        print(e)
        print("")
        dependencies.remove(e.req.__str__())
        errs += 1
        continue

    return errs

def get_args():
  parser = argparse.ArgumentParser(
      description=
      "Checks your installed pip packages against a requirements.txt file."
  )
  parser.add_argument('filename', type=str, help='requirements file')
  args = parser.parse_args()
  return args


if __name__ == '__main__':
  args = get_args()
  # print(args.filename)
  check_dependencies(args.filename)
#  run(apikey=args.api_key,

