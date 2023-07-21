#!/bin/bash

git clone https://github.com/susumuota/qlora.git
cd qlora

python -m venv venv
source venv/bin/activate

pip install torch --index-url https://download.pytorch.org/whl/cu118

pip install -U -r requirements.txt
