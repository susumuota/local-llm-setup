# https://huggingface.co/docs/transformers/main/model_doc/llama#transformers.LlamaForCausalLM.forward.example

import sys

import torch
from transformers import LlamaForCausalLM, LlamaTokenizer

path = sys.argv[1] or "7B"
print("path:", path)

torch.set_num_threads(8)

tokenizer = LlamaTokenizer.from_pretrained(path)
print("tokenizer:", tokenizer)

model = LlamaForCausalLM.from_pretrained(path)
print("model:", model)

prompt = "Hey, are you conscious? Can you talk to me?"
print("prompt:", prompt)

inputs = tokenizer(prompt, return_tensors="pt")
print("inputs:", inputs)

generate_ids = model.generate(inputs.input_ids, max_length=30)
print("generate_ids:", generate_ids)

decoded = tokenizer.batch_decode(generate_ids, skip_special_tokens=True, clean_up_tokenization_spaces=False)[0]
print("decoded:", decoded)
