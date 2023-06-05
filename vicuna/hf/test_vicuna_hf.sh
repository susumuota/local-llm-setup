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
python -m fastchat.serve.cli --model-path "${model_path}" --device cpu --load-8bit --max-new-tokens 128 --style rich
