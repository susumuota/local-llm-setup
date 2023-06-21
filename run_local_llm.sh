#!/bin/bash

# https://github.com/ggerganov/llama.cpp/blob/master/examples/main/README.md

cd ~/Documents/python/local-llm-setup/llama.cpp
./main -t 8 -c 2048 -i --color -e --multiline-input \
  -m ~/Documents/python/local-llm-setup/Wizard-Vicuna-13B-Uncensored.ggmlv3.q6_K.bin \
  -r "USER:" --in-prefix " " --in-suffix "ASSISTANT:" \
  -p "A chat between a curious user and an artificial intelligence assistant. The assistant gives helpful, detailed, and polite answers to the user's questions.\n\nUSER: Hello\nASSISTANT: Hi!\nUSER: How are you?\nASSISTANT:"
