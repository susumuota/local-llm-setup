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

# TODO: find 65B files in huggingface
if [ "${model_size}" = "65B" ]; then
  echo "65B is not available yet."
  exit 1
fi

script_dir=$(cd $(dirname $0); pwd)
output_dir="${script_dir}/${model_size}"

declare -A repos=(
  ["7B"]="TheBloke/LLaMa-7B-GGML"
  ["13B"]="TheBloke/LLaMa-13B-GGML"
  ["30B"]="TheBloke/LLaMa-30B-GGML"
  ["65B"]="TODO/TODO"                # TODO: find 65B files in huggingface
)

repo="${repos[${model_size}]}"
echo "repo: ${repo}"

qs=("q4_0" "q4_1" "q5_0" "q5_1" "q8_0")

mkdir -p "${output_dir}"
for q in "${qs[@]}"; do
  # echo "https://huggingface.co/${repo}/resolve/main/llama-${model_size,,}.ggmlv3.${q}.bin"
  aria2c -x 5 --auto-file-renaming=false -d "${output_dir}" "https://huggingface.co/${repo}/resolve/main/llama-${model_size,,}.ggmlv3.${q}.bin" -o "llama-${model_size,,}.ggmlv3.${q}.bin"
done

(cd "${output_dir}" && md5sum -c "${script_dir}/llama_${model_size,,}_ggml.md5")
(cd "${output_dir}" && sha256sum -c "${script_dir}/llama_${model_size,,}_ggml.sha256")
