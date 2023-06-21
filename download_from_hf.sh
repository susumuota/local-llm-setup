#!/bin/bash

# url must be https://huggingface.co/TheBloke/vicuna-13b-1.1-GGML/blob/main/vicuna-13b-1.1.ggmlv3.q6_K.bin

url=$1
output_dir=$2

if [[ ${url} =~ ^https://huggingface.co/([^/]+)/([^/]+)/([^/]+)/([^/]+)/(.+)$ ]]; then
  user="${BASH_REMATCH[1]}"
  repo="${BASH_REMATCH[2]}"
  type="${BASH_REMATCH[3]}"
  branch="${BASH_REMATCH[4]}"
  file="${BASH_REMATCH[5]}"
  echo "user: ${user}"
  echo "repo: ${repo}"
  echo "type: ${type}"
  echo "branch: ${branch}"
  echo "file: ${file}"
else
  echo "Usage: $0 <huggingface-url> [output_dir]"
  echo "e.g. $0 \"https://huggingface.co/TheBloke/vicuna-13b-1.1-GGML/blob/main/vicuna-13b-1.1.ggmlv3.q6_K.bin\""
  exit 1
fi

if [ -z "${output_dir}" ]; then
  output_dir="."
fi

checksum=$(curl -s "https://huggingface.co/${user}/${repo}/raw/${branch}/${file}" | sed -nE "s/^oid (.+):(.+)$/\2/ p")
echo "${checksum}  ${file}" > "${output_dir}/${file}.sha256"
echo "checksum: ${checksum}"

mkdir -p "${output_dir}"

aria2c -x 5 --auto-file-renaming=false -d "${output_dir}" "https://huggingface.co/${user}/${repo}/resolve/${branch}/${file}" -o "${file}"

(cd "${output_dir}" && sha256sum -c "${file}.sha256")
