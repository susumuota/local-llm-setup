#!/bin/bash

sudo apt-get update && sudo apt-get install -y --no-install-recommends \
  aria2 \
  emacs \
  git \
  python-is-python3 \
  python3 \
  python3-pip \
  python3-venv \
  && sudo rm -rf /var/lib/apt/lists/*
