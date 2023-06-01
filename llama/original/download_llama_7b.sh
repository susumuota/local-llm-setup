#!/bin/bash

script_dir=$(cd $(dirname $0); pwd)
dir="${script_dir}/7B"

mkdir -p "${dir}"
aria2c -x 5 --auto-file-renaming=false -d "${dir}" "https://huggingface.co/nyanko7/LLaMA-7B/resolve/main/consolidated.00.pth" -o "consolidated.00.pth"
aria2c -x 5 --auto-file-renaming=false -d "${dir}" "https://huggingface.co/nyanko7/LLaMA-7B/resolve/main/params.json" -o "params.json"

(cd "${dir}" && md5sum -c "${script_dir}/llama_7b.md5")
(cd "${dir}" && sha256sum -c "${script_dir}/llama_7b.sha256")
