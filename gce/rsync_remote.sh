#!/bin/bash

# create a bucket before running this script
# gsutil mb -l us-central1 gs://llm-outputs-1

src="output"
dst="gs://llm-outputs-1/output"  # edit here
wait=600

# cd qlora
mkdir -p "$src"
while true ; do gsutil -m rsync -r "$src" "$dst" ; sleep $wait ; done
