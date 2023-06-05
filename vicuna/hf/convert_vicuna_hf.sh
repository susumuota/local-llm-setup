#!/bin/bash

# ask model_size if not specified
if [ -z "$1" ]; then
  read -p "Enter model_size (7B, 13B): " model_size
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

input_dir="${script_dir}/../../llama/hf/${model_size}"
output_dir="${script_dir}/converted/${model_size}"

mkdir -p "${output_dir}"
source "${script_dir}/venv/bin/activate"
python -m fastchat.model.apply_delta --base-model-path "${input_dir}" --target-model-path "${output_dir}" --delta-path "lmsys/vicuna-${model_size,,}-delta-v1.1"

(cd "${output_dir}" && md5sum -c "${script_dir}/vicuna_${model_size,,}_hf.md5")
(cd "${output_dir}" && sha256sum -c "${script_dir}/vicuna_${model_size,,}_hf.sha256")
