"""
Template for new python files.
"""

from __future__ import absolute_import, division, print_function

import argparse
import glob
import numpy as np
import os
import pandas as pd
import pdb
import pickle
import regex as re
import sys
import yaml

from tqdm import tqdm

def run(arg1, arg2, arg3, arg4):
  pass

def get_args():
  parser = argparse.ArgumentParser(
      description=
      "Description goes here"
  )
  parser.add_argument('-a', '--api_key', type=str, required=True, help='api key')
  parser.add_argument('-d',   '--deployment', default = 'prod', type = str,
                      help = "Deployment level: dev, staging, prod")
  parser.add_argument('--begin_stage', type=int, default=1, help="First stage to execute")
  parser.add_argument('--end_stage', type=int, default=999, help="Last stage to execute")
  parser.add_argument("filename", type=str, "positional arg")
  args = parser.parse_args()
  return args

if __name__ == '__main__':
  args = get_args()
  run(apikey=args.api_key,
      deployment=args.deployment,
      begin_stage=args.begin_stage,
      end_stage=args.end_stage
      )