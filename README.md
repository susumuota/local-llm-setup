# Local LLM Setup

This repository collects scripts and checksum files to setup Local LLM.

- Setup instructions
- Download scripts
- Convert scripts
- Test scripts
- Checksum files

## How to run LLM on your laptop machine

I confirmed that llama.cpp can run 13B models on my laptop machine (MacBook Pro 13-inch, 2020, Intel Core i5, 16GB RAM, no GPUs) with reasonable speed.

```bash
git clone https://github.com/ggerganov/llama.cpp.git
cd llama.cpp
aria2c -x 5 "https://huggingface.co/TheBloke/Wizard-Vicuna-13B-Uncensored-GGML/resolve/main/Wizard-Vicuna-13B-Uncensored.ggmlv3.q6_K.bin" -d "models" -o "Wizard-Vicuna-13B-Uncensored.ggmlv3.q6_K.bin"
make
answers to the user's questions.\n\nUSER: Hello\nASSISTANT: Hi\nUSER: How are you?\nASSISTANT:"
./main -t 8 -c 2048 -i --color -e \
  -m "../Wizard-Vicuna-13B-Uncensored.ggmlv3.q6_K.bin" \
  -r "USER:" --in-prefix " " --in-suffix "ASSISTANT:" \
  -p "A chat between a curious user and an artificial intelligence assistant. The assistant gives helpful, detailed, and polite answers to the user's questions.\n\nUSER: Hello\nASSISTANT: Hi\nUSER: How are you?\nASSISTANT:"
```

## How to run LLM on GCE

See [gce](gce) directory.

## LLM Leader board

Here are links to the LLM Leaderboard. I check these links to find the latest LLM models.

### Open LLM Leaderboard

- https://huggingface.co/spaces/HuggingFaceH4/open_llm_leaderboard

- Best models of each parameter size

| Size | Model | Average Score | Note |
| --- | --- | --- | --- |
| 65B | [timdettmers/guanaco-65b-merged](https://huggingface.co/timdettmers/guanaco-65b-merged) | 62.2 |  |
| 40B | [tiiuae/falcon-40b-instruct](https://huggingface.co/tiiuae/falcon-40b-instruct) | 63.2 | Not LLaMA based |
| 30B | [CalderaAI/30B-Lazarus](https://huggingface.co/CalderaAI/30B-Lazarus) | 60.7 |  |
| 13B | [TheBloke/Wizard-Vicuna-13B-Uncensored-HF](https://huggingface.co/TheBloke/Wizard-Vicuna-13B-Uncensored-HF) | 57.0 |  |
| 7B | [eachadea/vicuna-7b-1.1](https://huggingface.co/eachadea/vicuna-7b-1.1) | 52.2 |  |

<img width="800" alt="image" src="https://github.com/susumuota/local-llm-setup/assets/1632335/7e50bcf4-20c8-4a0a-8b98-4c61e287c1b0">

### GPT4All Performance Benchmarks

- https://gpt4all.io/index.html  (see `Performance Benchmarks` section)

<img width="800" alt="image" src="https://github.com/susumuota/local-llm-setup/assets/1632335/3c0037d5-22e1-462d-ab69-c75f5fd92508">

### Chatbot Arena Leaderboard

- https://lmsys.org/blog/2023-05-25-leaderboard/
- https://chat.lmsys.org/  (see `Leaderboard` tab)

<img width="800" alt="image" src="https://github.com/susumuota/local-llm-setup/assets/1632335/6b5ac69e-7186-44cb-997d-4afb682b1912">

## LLaMA

- Paper
  - https://arxiv.org/abs/2302.13971
- Repository
  - https://github.com/facebookresearch/llama
- How to download, convert, and test
  - See [llama/original](llama/original)
  - See [llama/hf](llama/hf)
  - See [llama/ggml](llama/ggml)

## Vicuna

![vicuna](https://github.com/susumuota/local-llm-setup/assets/1632335/ea8503f8-00a1-41f0-aa81-2290403c8475)

- Blog
  - https://lmsys.org/blog/2023-03-30-vicuna/
- Repository
  - https://github.com/lm-sys/FastChat
- How to download, convert, and test
  - See [vicuna/hf](vicuna/hf)
  - See [vicuna/ggml](vicuna/ggml)

## Guanaco

- Best 65B model on the Open LLM Leaderboard

<img width="527" alt="image" src="https://github.com/susumuota/local-llm-setup/assets/1632335/360c26fb-b293-4ae6-b6d2-2010a2c2e258">

- Paper
  - https://arxiv.org/abs/2305.14314
- Repository
  - https://github.com/artidoro/qlora
- Weights
  - https://huggingface.co/timdettmers
- How to run
  - 65B model should work with 64GB RAM machine (48GB RAM might be enough but not tested)

```sh
bash download_from_hf.sh https://huggingface.co/TheBloke/guanaco-65B-GGML/blob/main/guanaco-65B.ggmlv3.q5_K_M.bin
(git clone https://github.com/ggerganov/llama.cpp && cd llama.cpp && make)  # for the first time
./llama.cpp/main -t 8 -m guanaco-65B.ggmlv3.q5_K_M.bin --color -c 2048 -i -r "### Human: " -e -p "A chat between a curious user and an artificial intelligence assistant. The assistant gives helpful, detailed, and polite answers to the user's questions.\n\n### Human: Hello\n### Assistant: Hi\n### Human: How are you?\n### Assistant:"
```

## WizardVicunaLM

- Best 13B model on the Open LLM Leaderboard

![wizard-vicuna](https://github.com/susumuota/local-llm-setup/assets/1632335/17548451-6cfd-4fbd-b6cf-b9f4473de7d3)

<img width="652" alt="image" src="https://github.com/susumuota/local-llm-setup/assets/1632335/2d7d0017-5249-4126-83c2-87a8559d0d56">

- Repository
  - https://github.com/melodysdreamj/WizardVicunaLM
  - https://huggingface.co/datasets/junelee/wizard_vicuna_70k
- Weights
  - https://huggingface.co/junelee/wizard-vicuna-13b
  - https://huggingface.co/ehartford/Wizard-Vicuna-13B-Uncensored
  - https://huggingface.co/TheBloke/Wizard-Vicuna-13B-Uncensored-HF
  - https://huggingface.co/TheBloke/Wizard-Vicuna-13B-Uncensored-GGML
- How to run

```sh
bash download_from_hf.sh https://huggingface.co/TheBloke/Wizard-Vicuna-13B-Uncensored-GGML/blob/main/Wizard-Vicuna-13B-Uncensored.ggmlv3.q6_K.bin
(git clone https://github.com/ggerganov/llama.cpp && cd llama.cpp && make)  # for the first time
./llama.cpp/main -t 7 -m Wizard-Vicuna-13B-Uncensored.ggmlv3.q6_K.bin --color -c 2048 -i -r "USER: " -e -p "A chat between a curious user and an artificial intelligence assistant. The assistant gives helpful, detailed, and polite answers to the user's questions.\n\nUSER: Hello\nASSISTANT: Hi\nUSER: How are you?\nASSISTANT:"
```

## Falcon

<img width="652" alt="image" src="https://github.com/susumuota/local-llm-setup/assets/1632335/2d7d0017-5249-4126-83c2-87a8559d0d56">

- Website
  - https://falconllm.tii.ae/
- Repository
  - https://huggingface.co/datasets/tiiuae/falcon-refinedweb
- Weights
  - https://huggingface.co/tiiuae
- How to setup
  - WIP

## Orca

- Paper
  - https://arxiv.org/abs/2306.02707
- Repository
  - https://aka.ms/orca-lm
- How to setup
  - WIP


## OpenLLaMA

- Repository
  - https://github.com/openlm-research/open_llama
- Weights
  - https://huggingface.co/openlm-research/open_llama_3b
  - https://huggingface.co/openlm-research/open_llama_7b
  - https://huggingface.co/openlm-research/open_llama_13b_600bt
- How to setup
  - WIP


## 30b-Lazarus

- Best 30B model on the Open LLM Leaderboard

```sh
bash download_from_hf.sh https://huggingface.co/TheBloke/30B-Lazarus-GGML/blob/main/30b-Lazarus.ggmlv3.q6_K.bin
(git clone https://github.com/ggerganov/llama.cpp && cd llama.cpp && make)  # for the first time
./llama.cpp/main -t 8 -m 30b-Lazarus.ggmlv3.q6_K.bin --color -c 2048 --temp 0.7 --repeat_penalty 1.1 -n -1 -i -r "### Human: " -e -p "A chat between a curious user and an artificial intelligence assistant. The assistant gives helpful, detailed, and polite answers to the user's questions.\n\n### Human: Hello\n### Assistant: Hi\n### Human: How are you?\n### Assistant:"
```
