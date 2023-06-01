#!/bin/bash

script_dir=$(cd $(dirname $0); pwd)
dir="${script_dir}/65B"

mkdir -p "${dir}"
aria2c -x 5 --auto-file-renaming=false -d "${dir}" "https://huggingface.co/datasets/nyanko7/LLaMA-65B/resolve/main/consolidated.00.pth" -o "consolidated.00.pth"
aria2c -x 5 --auto-file-renaming=false -d "${dir}" "https://huggingface.co/datasets/nyanko7/LLaMA-65B/resolve/main/consolidated.01.pth" -o "consolidated.01.pth"
aria2c -x 5 --auto-file-renaming=false -d "${dir}" "https://huggingface.co/datasets/nyanko7/LLaMA-65B/resolve/main/consolidated.02.pth" -o "consolidated.02.pth"
aria2c -x 5 --auto-file-renaming=false -d "${dir}" "https://huggingface.co/datasets/nyanko7/LLaMA-65B/resolve/main/consolidated.03.pth" -o "consolidated.03.pth"
aria2c -x 5 --auto-file-renaming=false -d "${dir}" "https://huggingface.co/datasets/nyanko7/LLaMA-65B/resolve/main/consolidated.04.pth" -o "consolidated.04.pth"
aria2c -x 5 --auto-file-renaming=false -d "${dir}" "https://huggingface.co/datasets/nyanko7/LLaMA-65B/resolve/main/consolidated.05.pth" -o "consolidated.05.pth"
aria2c -x 5 --auto-file-renaming=false -d "${dir}" "https://huggingface.co/datasets/nyanko7/LLaMA-65B/resolve/main/consolidated.06.pth" -o "consolidated.06.pth"
aria2c -x 5 --auto-file-renaming=false -d "${dir}" "https://huggingface.co/datasets/nyanko7/LLaMA-65B/resolve/main/consolidated.07.pth" -o "consolidated.07.pth"
aria2c -x 5 --auto-file-renaming=false -d "${dir}" "https://huggingface.co/datasets/nyanko7/LLaMA-65B/resolve/main/params.json" -o "params.json"

(cd "${dir}" && md5sum -c "${script_dir}/llama_65b.md5")
(cd "${dir}" && sha256sum -c "${script_dir}/llama_65b.sha256")
