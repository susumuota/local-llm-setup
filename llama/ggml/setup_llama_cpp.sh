#!/bin/bash

script_dir=$(cd $(dirname $0); pwd)

git clone https://github.com/ggerganov/llama.cpp "${script_dir}/llama.cpp"
(cd "${script_dir}/llama.cpp" && make)

# python -V  # Python 3.10.11
python -m venv "${script_dir}/venv"
source "${script_dir}/venv/bin/activate"
pip install -r "${script_dir}/llama.cpp/requirements.txt"
