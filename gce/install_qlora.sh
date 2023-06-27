#!/bin/bash

sudo apt-get update && sudo apt-get install -y --no-install-recommends \
  git \
  python-is-python3 \
  python3 \
  python3-pip \
  python3-venv \
  && sudo rm -rf /var/lib/apt/lists/*

git clone https://github.com/artidoro/qlora.git
cd qlora

python -m venv venv
source venv/bin/activate

pip install torch --index-url https://download.pytorch.org/whl/cu118

pip install -U -r requirements.txt
