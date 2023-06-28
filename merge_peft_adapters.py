# https://huggingface.co/TheBloke/vicuna-13b-v1.3-preview-GPTQ/discussions/1#6491785909d6848c5ef46b08

# python -m venv venv
# source venv/bin/activate
# pip install torch transformers peft
# python merge_peft_adapters.py --base_model_name_or_path huggyllama/llama-7b --peft_model_path timdettmers/guanaco-7b --output_dir test-7b --device cpu  # noqa

from transformers import AutoModelForCausalLM, AutoTokenizer
from peft import PeftModel
import torch

import argparse


def get_args():
    parser = argparse.ArgumentParser()
    parser.add_argument("--base_model_name_or_path", type=str)
    parser.add_argument("--peft_model_path", type=str)
    parser.add_argument("--output_dir", type=str)
    parser.add_argument("--device", type=str, default="auto")
    parser.add_argument("--push_to_hub", action="store_true")
    parser.add_argument("--trust_remote_code", action="store_true")

    return parser.parse_args()


def main():
    args = get_args()

    if args.device == 'auto':
        device_arg = {'device_map': 'auto'}
    else:
        device_arg = {'device_map': {"": args.device}}

    print(f"Loading base model: {args.base_model_name_or_path}")
    base_model = AutoModelForCausalLM.from_pretrained(
        args.base_model_name_or_path,
        return_dict=True,
        torch_dtype=torch.float16,
        trust_remote_code=args.trust_remote_code,
        **device_arg
    )

    print(f"Loading PEFT: {args.peft_model_path}")
    model = PeftModel.from_pretrained(base_model, args.peft_model_path, **device_arg)  # noqa
    print("Running merge_and_unload")
    model = model.merge_and_unload()

    tokenizer = AutoTokenizer.from_pretrained(args.base_model_name_or_path)

    if args.push_to_hub:
        print("Saving to hub ...")
        model.push_to_hub(f"{args.output_dir}", use_temp_dir=False)
        tokenizer.push_to_hub(f"{args.output_dir}", use_temp_dir=False)
    else:
        model.save_pretrained(f"{args.output_dir}")
        tokenizer.save_pretrained(f"{args.output_dir}")
        print(f"Model saved to {args.output_dir}")


if __name__ == "__main__":
    main()
