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

# TODO: find 30B files in huggingface
if [ "${model_size}" = "30B" ]; then
  echo "30B is not available yet."
  exit 1
fi

script_dir=$(cd $(dirname $0); pwd)
output_dir="${script_dir}/${model_size}"

declare -A repos=(
  ["7B"]="nyanko7/LLaMA-7B"
  ["13B"]="TheBloke/llama-13b"
  ["30B"]="TODO/TODO"                    # TODO: find 30B files in huggingface
  ["65B"]="datasets/nyanko7/LLaMA-65B"
)

repo="${repos[${model_size}]}"
echo "repo: ${repo}"

declare -A n_shards=(
  ["7B"]="0"
  ["13B"]="1"
  ["30B"]="3"
  ["65B"]="7"
)

n_shard="${n_shards[${model_size}]}"
echo "n_shard: ${n_shard}"

mkdir -p "${output_dir}"
for i in $(seq -f "%02g" 0 ${n_shard}); do
  # echo "https://huggingface.co/${repo}/resolve/main/consolidated.${i}.pth"
  aria2c -x 5 --auto-file-renaming=false -d "${output_dir}" "https://huggingface.co/${repo}/resolve/main/consolidated.${i}.pth" -o "consolidated.${i}.pth"
done
aria2c -x 5 --auto-file-renaming=false -d "${output_dir}" "https://huggingface.co/${repo}/resolve/main/params.json" -o "params.json"

(cd "${output_dir}" && md5sum -c "${script_dir}/llama_${model_size,,}.md5")
(cd "${output_dir}" && sha256sum -c "${script_dir}/llama_${model_size,,}.sha256")
