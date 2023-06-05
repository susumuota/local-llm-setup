# Download Vicuna HuggingFace format weights

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

## Download Vicuna HuggingFace format weights

```bash
bash download_vicuna_hf.sh 7B
bash download_vicuna_hf.sh 13B
```

## Checksum

I converted LLaMA original weights to HuggingFace weights, applied delta and generated checksum files.

I confirmed `md5sum -c vicuna_7b_hf.md5` and `sha256sum -c vicuna_7b_hf.sha256` are passed with converted files.

Also, `13B` checksum files are confirmed as same as `7B`.

Here's links to confirm the SHA256 checksum by others.

- 7B
  - https://huggingface.co/TheBloke/vicuna-7B-1.1-HF/blob/main/pytorch_model-00001-of-00002.bin
  - https://huggingface.co/TheBloke/vicuna-7B-1.1-HF/blob/main/pytorch_model-00002-of-00002.bin
- 13B
  - https://huggingface.co/TheBloke/vicuna-13B-1.1-HF/blob/main/pytorch_model-00001-of-00003.bin
  - https://huggingface.co/TheBloke/vicuna-13B-1.1-HF/blob/main/pytorch_model-00002-of-00003.bin
  - https://huggingface.co/TheBloke/vicuna-13B-1.1-HF/blob/main/pytorch_model-00003-of-00003.bin

## Convert LLaMA HuggingFace weights to Vicuna HuggingFace weights

You can convert LLaMA HuggingFace weights to Vicuna HuggingFace weights by `fastchat` module.

- https://github.com/lm-sys/FastChat#vicuna-weights

Setup Python environment and install `fastchat` module.

```bash
bash setup_python_env.sh
```

Run convert script.

```bash
bash convert_vicuna_hf.sh 7B
bash convert_vicuna_hf.sh 13B
```

## Test converted weights

```bash
bash test_vicuna_hf.sh 7B
bash test_vicuna_hf.sh 13B
```
