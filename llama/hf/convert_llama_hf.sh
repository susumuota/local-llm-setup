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

input_dir="${script_dir}/../original"
output_dir="${script_dir}/hf/${model_size}"

mkdir -p "${output_dir}"
source "${script_dir}/venv/bin/activate"
python "${script_dir}/convert_llama_weights_to_hf.py" --input_dir "${input_dir}" --model_size "${model_size}" --output_dir "${output_dir}"

(cd "${output_dir}" && md5sum -c "${script_dir}/llama_${model_size,,}_hf.md5")
(cd "${output_dir}" && sha256sum -c "${script_dir}/llama_${model_size,,}_hf.sha256")
