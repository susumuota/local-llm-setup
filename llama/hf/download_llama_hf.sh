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
output_dir="${script_dir}/${model_size}"

declare -A repos=(
  ["7B"]="elinas/llama-7b-hf-transformers-4.29"
  ["13B"]="elinas/llama-13b-hf-transformers-4.29"
  ["30B"]="elinas/llama-30b-hf-transformers-4.29"  # TODO: confirm checksum
  ["65B"]="elinas/llama-65b-hf-transformers-4.29"  # TODO: confirm checksum
)

repo="${repos[${model_size}]}"
echo "repo: ${repo}"

declare -A n_shards=(
  ["7B"]="2"
  ["13B"]="3"
  ["30B"]="7"
  ["65B"]="14"
)

n_shard="${n_shards[${model_size}]}"
echo "n_shard: ${n_shard}"

mkdir -p "${output_dir}"
end=$(seq -f "%05g" ${n_shard} ${n_shard})
for i in $(seq -f "%05g" 1 ${n_shard}); do
  # echo "https://huggingface.co/${repo}/resolve/main/pytorch_model-${i}-of-${end}.bin"
  aria2c -x 5 --auto-file-renaming=false -d "${output_dir}" "https://huggingface.co/${repo}/resolve/main/pytorch_model-${i}-of-${end}.bin" -o "pytorch_model-${i}-of-${end}.bin"
done
aria2c -x 5 --auto-file-renaming=false -d "${output_dir}" "https://huggingface.co/${repo}/resolve/main/tokenizer.model" -o "tokenizer.model"

(cd "${output_dir}" && md5sum -c "${script_dir}/llama_${model_size,,}_hf.md5")
(cd "${output_dir}" && sha256sum -c "${script_dir}/llama_${model_size,,}_hf.sha256")
