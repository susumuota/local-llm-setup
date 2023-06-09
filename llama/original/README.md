# Download LLaMA original weights

## Download from HuggingFace

### Preparation

aria2 (for `aria2c`) and coreutils (for `md5sum` and `sha256sum`) are required to download files.

For Ubuntu,

```bash
sudo apt-get install aria2 coreutils
```

For macOS,

```bash
brew install aria2 coreutils
```

### Download

```bash
bash download_llama_tokenizer.sh
bash download_llama_weights.sh 7B
bash download_llama_weights.sh 13B
# bash download_llama_weights.sh 30B  # could not find 30B files in huggingface
bash download_llama_weights.sh 65B
```

### Checksum

`llama_7b.md5` is exactly the same as original `checklist.chk` downloaded from Meta's link.

`llama_7b.sha256` is generated by `sha256sum consolidated.0*.pth params.json > llama_7b.sha256` with original `consolidated.*.pth` downloaded from Meta's link.

I confirmed `md5sum -c llama_7b.md5` and `sha256sum -c llama_7b.sha256` are passed with original files.

Also, `13B`, `30B` and `65B` checksum files are confirmed as same as `7B`.

Here's links to confirm the MD5 and SHA256 checksum by others.

- MD5
  - https://github.com/ggerganov/llama.cpp/issues/238#issue-1629261965
  - https://huggingface.co/nyanko7/LLaMA-7B/blob/main/checklist.chk
  - https://huggingface.co/TheBloke/llama-13b/blob/main/checklist.chk
  - https://huggingface.co/datasets/nyanko7/LLaMA-65B/blob/main/checklist.chk
- SHA256
  - https://github.com/ggerganov/llama.cpp/blob/master/SHA256SUMS
  - https://github.com/ggerganov/llama.cpp/issues/238#issuecomment-1476679176
  - https://github.com/facebookresearch/llama/pull/87#issuecomment-1454265479
  - https://www.reddit.com/r/ChatGPT/comments/11gopy3/comment/jatiptn/?context=1


## Download from Meta's link

You should have received an email from Meta with a presigned url to download the weights.

- Clone repository.

```bash
git clone https://github.com/facebookresearch/llama.git
cd llama
```

- Install dependencies for macOS.

`bash` in macOS is too old to run `download.sh`.

```bash
brew install bash coreutils wget
rehash
```

- Edit `download.sh`.

```bash
PRESIGNED_URL="https://..."   # replace with presigned url from email
TARGET_FOLDER="/Volumes/LLAMA/original"
```

- Create the target folder. It should need ~220GB.

```bash
mkdir -p "/Volumes/LLAMA/original"
```

- Run `download.sh`.

```bash
bash download.sh
```
