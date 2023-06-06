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
output_dir="${script_dir}/${model_size}"

declare -A repos=(
  ["7B"]="CRD716/ggml-vicuna-1.1-quantized"
  ["13B"]="CRD716/ggml-vicuna-1.1-quantized"
)

repo="${repos[${model_size}]}"
echo "repo: ${repo}"

qs=("q4_0" "q4_1" "q5_0" "q5_1" "q8_0")

mkdir -p "${output_dir}"

# TODO: need to fix this...
# https://huggingface.co/CRD716/ggml-vicuna-1.1-quantized/tree/main
if [ "${model_size}" = "7B" ]; then
  m="${model_size,,}"
else
  m="${model_size}"
fi

for q in "${qs[@]}"; do
  # echo "https://huggingface.co/${repo}/resolve/main/ggml-vicuna-${m}-1.1-${q}.bin"
  aria2c -x 5 --auto-file-renaming=false -d "${output_dir}" "https://huggingface.co/${repo}/resolve/main/ggml-vicuna-${m}-1.1-${q}.bin" -o "vicuna-${model_size,,}.ggmlv3.${q}.bin"
done

(cd "${output_dir}" && md5sum -c "${script_dir}/vicuna_${model_size,,}_ggml.md5")
(cd "${output_dir}" && sha256sum -c "${script_dir}/vicuna_${model_size,,}_ggml.sha256")
