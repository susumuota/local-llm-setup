#!/bin/bash

# create a bucket before running this script
# gsutil mb -l us-central1 gs://llm-outputs-1

src="gs://llm-outputs-1/output"  #edit here
dst="output"
wait=600

mkdir -p "$dst"
while true ; do gsutil -m rsync -r "$src" "$dst" ; sleep $wait ; done
