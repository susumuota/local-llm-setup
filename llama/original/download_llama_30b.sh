#!/bin/bash

script_dir=$(cd $(dirname $0); pwd)
dir="${script_dir}/30B"

mkdir -p "${dir}"
# could not find 30B files in huggingface
# aria2c -x 5 --auto-file-renaming=false -d "${dir}" "https://huggingface.co/nyanko7/LLaMA-7B/resolve/main/consolidated.00.pth" -o "consolidated.00.pth"
# aria2c -x 5 --auto-file-renaming=false -d "${dir}" "https://huggingface.co/nyanko7/LLaMA-7B/resolve/main/params.json" -o "params.json"

(cd "${dir}" && md5sum -c "${script_dir}/llama_30b.md5")
(cd "${dir}" && sha256sum -c "${script_dir}/llama_30b.sha256")
