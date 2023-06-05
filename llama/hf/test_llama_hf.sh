#!/bin/bash

# ask model_path if not specified
if [ -z "$1" ]; then
  read -p "Enter model_path: " model_path
else
  model_path=$1
fi

# check model_path
if [ -z "${model_path}" ]; then
  echo "Usage: $0 <model_path>"
  exit 1
fi

echo "model_path: ${model_path}"

script_dir=$(cd $(dirname $0); pwd)

source "${script_dir}/venv/bin/activate"
python "${script_dir}/test_llama_hf.py" "${model_path}"
