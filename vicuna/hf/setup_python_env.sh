#!/bin/bash

script_dir=$(cd $(dirname $0); pwd)

# python -V  # Python 3.10.11
python -m venv "${script_dir}/venv"
source "${script_dir}/venv/bin/activate"
pip install fschat
