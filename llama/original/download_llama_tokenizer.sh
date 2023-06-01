#!/bin/bash

script_dir=$(cd $(dirname $0); pwd)
output_dir="${script_dir}"

mkdir -p "${output_dir}"
aria2c -x 5 --auto-file-renaming=false -d "${output_dir}" "https://huggingface.co/nyanko7/LLaMA-7B/resolve/main/tokenizer.model" -o "tokenizer.model"

(cd "${output_dir}" && md5sum -c llama_tokenizer.md5)
(cd "${output_dir}" && sha256sum -c llama_tokenizer.sha256)
