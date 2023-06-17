# Local LLM Setup

This repository collects scripts and checksum files to setup Local LLM.

- Setup instructions
- Download scripts
- Convert scripts
- Test scripts
- Checksum files

## How to run LLM on your laptop machine

I confirmed that llama.cpp can run 13B model on my laptop machine (MacBook Pro 13-inch, 2020, Intel Core i5, 16GB RAM, no GPUs) with reasonable speed.

```bash
git clone https://github.com/ggerganov/llama.cpp.git
cd llama.cpp
aria2c -x 5 -d models https://huggingface.co/TheBloke/Wizard-Vicuna-13B-Uncensored-GGML/resolve/main/Wizard-Vicuna-13B-Uncensored.ggmlv3.q6_K.bin -o Wizard-Vicuna-13B-Uncensored.ggmlv3.q6_K.bin
make
./main -t 7 -m models/Wizard-Vicuna-13B-Uncensored.ggmlv3.q6_K.bin --color -c 2048 --temp 0.7 --repeat_penalty 1.1 -n -1 -i -r "USER: " -e -p "A chat between a curious user and an artificial intelligence assistant. The assistant gives helpful, detailed, and polite answers to the user's questions.\n\nUSER: Hello\nASSISTANT: Hi\nUSER: How are you?\nASSISTANT:"
```


## LLM Leader board

Here are links to the LLM Leaderboard. I check these links to find the latest LLM models.

### Open LLM Leaderboard

- https://huggingface.co/spaces/HuggingFaceH4/open_llm_leaderboard

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
  - [llama/original](llama/original)
  - [llama/hf](llama/hf)
  - [llama/ggml](llama/ggml)

## Vicuna

![vicuna](https://github.com/susumuota/local-llm-setup/assets/1632335/ea8503f8-00a1-41f0-aa81-2290403c8475)

- Blog
  - https://lmsys.org/blog/2023-03-30-vicuna/
- Repository
  - https://github.com/lm-sys/FastChat
- How to download, convert, and test
  - [vicuna/hf](vicuna/hf)
  - [vicuna/ggml](vicuna/ggml)

## Guanaco

<img width="527" alt="image" src="https://github.com/susumuota/local-llm-setup/assets/1632335/360c26fb-b293-4ae6-b6d2-2010a2c2e258">

- Paper
  - https://arxiv.org/abs/2305.14314
- Repository
  - https://github.com/artidoro/qlora
- Weights
  - https://huggingface.co/timdettmers
- How to run
  - WIP

## WizardVicunaLM

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
./llama.cpp/main -t 7 -m Wizard-Vicuna-13B-Uncensored.ggmlv3.q6_K.bin --color -c 2048 --temp 0.7 --repeat_penalty 1.1 -n -1 -i -r "USER: " -e -p "A chat between a curious user and an artificial intelligence assistant. The assistant gives helpful, detailed, and polite answers to the user's questions.\n\nUSER: Hello\nASSISTANT: Hi\nUSER: How are you?\nASSISTANT:"
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
