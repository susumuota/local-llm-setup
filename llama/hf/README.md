# Download LLaMA HuggingFace format weights

## Preparation

aria2 (for `aria2c`) and coreutils (for `md5sum` and `sha256sum`) are required to download files.

For Ubuntu,

```bash
sudo apt-get install aria2 coreutils
```

For macOS,

```bash
brew install aria2 coreutils
```

## Download LLaMA HuggingFace format weights

```bash
bash download_llama_hf.sh 7B
bash download_llama_hf.sh 13B
bash download_llama_hf.sh 30B
bash download_llama_hf.sh 65B
```

## Checksum

I converted LLaMA original weights to HuggingFace weights and generated checksum files.

I confirmed `md5sum -c llama_7b_hf.md5` and `sha256sum -c llama_7b_hf.sha256` are passed with converted files.

Also, `13B` checksum files are confirmed as same as `7B`. But `30B` and `65B` checksum files are not confirmed yet.

Here's links to confirm the SHA256 checksum by others.

- 7B
  - https://huggingface.co/elinas/llama-7b-hf-transformers-4.29/blob/main/pytorch_model-00001-of-00002.bin
  - https://huggingface.co/elinas/llama-7b-hf-transformers-4.29/blob/main/pytorch_model-00002-of-00002.bin
- 13B
  - https://huggingface.co/elinas/llama-13b-hf-transformers-4.29/blob/main/pytorch_model-00001-of-00003.bin
  - https://huggingface.co/elinas/llama-13b-hf-transformers-4.29/blob/main/pytorch_model-00002-of-00003.bin
  - https://huggingface.co/elinas/llama-13b-hf-transformers-4.29/blob/main/pytorch_model-00003-of-00003.bin
- 30B
  - https://huggingface.co/elinas/llama-30b-hf-transformers-4.29/blob/main/pytorch_model-00001-of-00007.bin
  - from `00001` to `00007`
- 65B
  - https://huggingface.co/elinas/llama-65b-hf-transformers-4.29/blob/main/pytorch_model-00001-of-00014.bin
  - from `00001` to `00014`

## Convert LLaMA original weights to HuggingFace weights

You can convert LLaMA original weights to HuggingFace weights by `convert_llama_original_to_hf.py`.

- https://huggingface.co/docs/transformers/main/model_doc/llama

Setup Python environment and download convert script.

```bash
bash setup_python_env.sh
```

Run convert script.

```bash
bash convert_llama_hf.sh 7B
bash convert_llama_hf.sh 13B
bash convert_llama_hf.sh 30B  # need high spec machine
bash convert_llama_hf.sh 65B  # need high spec machine
```

## Test converted weights

```bash
bash test_llama_hf.sh 7B
bash test_llama_hf.sh 13B
bash test_llama_hf.sh 30B  # need high spec machine
bash test_llama_hf.sh 65B  # need high spec machine
```
