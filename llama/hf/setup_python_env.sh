#!/bin/bash

script_dir=$(cd $(dirname $0); pwd)

# python -V  # Python 3.10.11
python -m venv "${script_dir}/venv"
source "${script_dir}/venv/bin/activate"
pip install transformers "transformers[torch]" "transformers[sentencepiece]"

aria2c -d "${script_dir}" "https://raw.githubusercontent.com/huggingface/transformers/main/src/transformers/models/llama/convert_llama_weights_to_hf.py" -o "convert_llama_weights_to_hf.py"
