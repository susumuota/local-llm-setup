# Download Vicuna GGML format weights

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

## Download Vicuna GGML weights

```bash
bash download_vicuna_ggml.sh 7B
bash download_vicuna_ggml.sh 13B
```

## Checksum

I converted Vicuna HuggingFace weights to GGML weights and generated checksum files.

I confirmed `md5sum -c vicuna_7b_ggml.md5` and `sha256sum -c vicuna_7b_ggml.sha256` are passed with converted files.

Also, `13B` checksum files are confirmed as same as `7B`.

Here's links to confirm the SHA256 checksum by others.

- 7B
  - https://huggingface.co/CRD716/ggml-vicuna-1.1-quantized/blob/main/ggml-vicuna-7b-1.1-q4_0.bin
  - https://huggingface.co/CRD716/ggml-vicuna-1.1-quantized/blob/main/ggml-vicuna-7b-1.1-q4_1.bin
  - https://huggingface.co/CRD716/ggml-vicuna-1.1-quantized/blob/main/ggml-vicuna-7b-1.1-q5_0.bin
  - https://huggingface.co/CRD716/ggml-vicuna-1.1-quantized/blob/main/ggml-vicuna-7b-1.1-q5_1.bin
  - https://huggingface.co/CRD716/ggml-vicuna-1.1-quantized/blob/main/ggml-vicuna-7b-1.1-q8_0.bin
- 13B
  - https://huggingface.co/CRD716/ggml-vicuna-1.1-quantized/blob/main/ggml-vicuna-13B-1.1-q4_0.bin
  - https://huggingface.co/CRD716/ggml-vicuna-1.1-quantized/blob/main/ggml-vicuna-13B-1.1-q4_1.bin
  - https://huggingface.co/CRD716/ggml-vicuna-1.1-quantized/blob/main/ggml-vicuna-13B-1.1-q5_0.bin
  - https://huggingface.co/CRD716/ggml-vicuna-1.1-quantized/blob/main/ggml-vicuna-13B-1.1-q5_1.bin
  - https://huggingface.co/CRD716/ggml-vicuna-1.1-quantized/blob/main/ggml-vicuna-13B-1.1-q8_0.bin

## Convert Vicuna HuggingFace weights to GGML weights

You can convert Vicuna HuggingFace weights to GGML weights by `convert.py`.

- https://github.com/ggerganov/llama.cpp#prepare-data--run

Setup llama.cpp and prepare to convert script.

```bash
bash setup_llama_cpp.sh
```

Run convert script.

```bash
bash convert_vicuna_ggml.sh 7B
bash convert_vicuna_ggml.sh 13B
```

## Test converted weights

```bash
cd llama.cpp
./main -m ../7B/vicuna-7b.ggmlv3.q4_0.bin -n 128 -t 8
```
