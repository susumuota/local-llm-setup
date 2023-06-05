# Download LLaMA GGML format weights

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

## Download LLaMA GGML weights

```bash
bash download_llama_ggml.sh 7B
bash download_llama_ggml.sh 13B
bash download_llama_ggml.sh 30B
# bash download_llama_ggml.sh 65B  # could not find 65B files in huggingface
```

## Checksum

I converted LLaMA original weights to GGML weights and generated checksum files.

I confirmed `md5sum -c llama_7b_ggml.md5` and `sha256sum -c llama_7b_ggml.sha256` are passed with converted files.

Also, `13B`, `30B` and `65B` checksum files are confirmed as same as `7B`.

Here's links to confirm the SHA256 checksum by others.

- fp16
  - https://github.com/ggerganov/llama.cpp/blob/master/SHA256SUMS
- q4_0, q4_1, q5_0, q5_1, q8_0
  - https://huggingface.co/TheBloke/LLaMa-7B-GGML/blob/main/llama-7b.ggmlv3.q4_0.bin
  - https://huggingface.co/TheBloke/LLaMa-7B-GGML/blob/main/llama-7b.ggmlv3.q4_1.bin
  - https://huggingface.co/TheBloke/LLaMa-7B-GGML/blob/main/llama-7b.ggmlv3.q5_0.bin
  - https://huggingface.co/TheBloke/LLaMa-7B-GGML/blob/main/llama-7b.ggmlv3.q5_1.bin
  - https://huggingface.co/TheBloke/LLaMa-7B-GGML/blob/main/llama-7b.ggmlv3.q8_0.bin
  - Change `7B` to `13B` or `30B` to confirm other models. But there are no `65B` files.

## Convert LLaMA original weights to GGML weights

You can convert LLaMA original weights to GGML weights by `convert.py`.

- https://github.com/ggerganov/llama.cpp#prepare-data--run

Setup llama.cpp and prepare to convert script.

```bash
bash setup_llama_cpp.sh
```

Run convert script.

```bash
bash convert_llama_ggml.sh 7B
bash convert_llama_ggml.sh 13B
bash convert_llama_ggml.sh 30B
bash convert_llama_ggml.sh 65B
```

## Test converted weights

```bash
cd llama.cpp
./main -m ../7B/llama-7b.ggmlv3.q4_0.bin -n 128 -t 8
```
