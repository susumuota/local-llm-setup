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

qs=("q4_0" "q4_1" "q5_0" "q5_1" "q8_0")

script_dir=$(cd $(dirname $0); pwd)

input_dir="${script_dir}/../hf/${model_size}"
output_dir="${script_dir}/converted/${model_size}"

mkdir -p "${output_dir}"
source "${script_dir}/venv/bin/activate"
python "${script_dir}/llama.cpp/convert.py" "${input_dir}" --outfile "${output_dir}/vicuna-${model_size,,}.ggmlv3.f16.bin"

for q in "${qs[@]}"; do
  (cd "${script_dir}/llama.cpp" && ./quantize "${output_dir}/vicuna-${model_size,,}.ggmlv3.f16.bin" "${output_dir}/vicuna-${model_size,,}.ggmlv3.${q}.bin" "${q}")
done

(cd "${output_dir}" && md5sum -c "${script_dir}/vicuna_${model_size,,}_ggml.md5")
(cd "${output_dir}" && sha256sum -c "${script_dir}/vicuna_${model_size,,}_ggml.sha256")
