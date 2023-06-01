#!/bin/bash

script_dir=$(cd $(dirname $0); pwd)
dir="${script_dir}"

mkdir -p "${dir}"
aria2c -x 5 --auto-file-renaming=false -d "${dir}" "https://huggingface.co/nyanko7/LLaMA-7B/resolve/main/tokenizer.model" -o "tokenizer.model"

(cd "${dir}" && md5sum -c llama_tokenizer.md5)
(cd "${dir}" && sha256sum -c llama_tokenizer.sha256)
