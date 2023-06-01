#!/bin/bash

# ask model_size if not specified
if [ -z "$1" ]; then
  read -p "Enter model_size (7B, 13B, 30B or 65B): " model_size
else
  model_size=$1
fi

# check model_size
if [ -z "${model_size}" ]; then
  echo "Usage: $0 <model_size>"
  exit 1
fi

echo "model_size: ${model_size}"

script_dir=$(cd $(dirname $0); pwd)

source "${script_dir}/venv/bin/activate"
python "${script_dir}/test_llama_hf.py" "${model_size}"
