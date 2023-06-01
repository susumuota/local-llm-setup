#!/bin/bash

script_dir=$(cd $(dirname $0); pwd)
dir="${script_dir}/13B"

mkdir -p "${dir}"
aria2c -x 5 --auto-file-renaming=false -d "${dir}" "https://huggingface.co/TheBloke/llama-13b/resolve/main/consolidated.00.pth" -o "consolidated.00.pth"
aria2c -x 5 --auto-file-renaming=false -d "${dir}" "https://huggingface.co/TheBloke/llama-13b/resolve/main/consolidated.01.pth" -o "consolidated.01.pth"
aria2c -x 5 --auto-file-renaming=false -d "${dir}" "https://huggingface.co/TheBloke/llama-13b/resolve/main/params.json" -o "params.json"

(cd "${dir}" && md5sum -c "${script_dir}/llama_13b.md5")
(cd "${dir}" && sha256sum -c "${script_dir}/llama_13b.sha256")
