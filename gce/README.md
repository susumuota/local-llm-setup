# How to run LLM on Google Compute Engine with or without GPU

## Install the gcloud CLI

Install the gcloud CLI because CLI is better than Web UI for automation and reproducibility.

- https://cloud.google.com/sdk/docs/install

But the web UI is also useful for checking the default or typical values of the settings. You can press `EQUIVALENT CODE` button to see the equivalent CLI command on the web UI.

## Create a project

Create a project. e.g. `local-llm-setup-2`. You should create a new project and then delete it later to avoid any unexpected charges.

- https://cloud.google.com/resource-manager/docs/creating-managing-projects#creating_a_project

```sh
export PROJECT_ID="local-llm-setup-2"
gcloud projects create $PROJECT_ID
gcloud projects list
# gcloud projects delete $PROJECT_ID
```

## Enable billing

Follow this instruction. I could not find any way to enable billing from the gcloud CLI.

- https://cloud.google.com/billing/docs/how-to/modify-project#how-to-enable-billing

Then confirm it.

```sh
gcloud beta billing projects describe $PROJECT_ID
```

It should show `billingEnabled: true`.

## Increase GPU quotas

- https://cloud.google.com/compute/quotas#requesting_additional_quota
- https://console.cloud.google.com/iam-admin/quotas

You need to increase `gpus_all_regions` from `0` to `1`.

## Choose region, zone, image and machine type

Choose a region. e.g. `us-central1`.

Choose a zone. e.g. `us-central1-a`.

Enable Compute Engine API.

- https://cloud.google.com/compute/docs/instances/create-start-instance#view-images

```sh
export REGION="us-central1"
export ZONE="us-central1-a"
gcloud services enable compute.googleapis.com --project=$PROJECT_ID
# gcloud services disable compute.googleapis.com --project=$PROJECT_ID
```

## Create an instance

Create an instance specifying the machine type, OS, disk, GPU, etc.

`SCOPES` specify GCP services that the instance can access. e.g. `storage-full` for GCS.

- instance without GPU

```sh
export PROJECT_ID="local-llm-setup-2"
export ZONE="us-central1-a"
export INSTANCE_NAME="instance-1"
export MACHINE_TYPE="c2-standard-16"   # vCPU: 16, RAM: 64GB. need to increase quota `c2_cpus` from `8` to `16`.
export SCOPES="default,storage-full"
export IMAGE_PROJECT="ubuntu-os-cloud"
export IMAGE_FAMILY="ubuntu-2204-lts"
export DISK_NAME="disk-1"
export DISK_SIZE="100GB"
export DISK_TYPE="pd-ssd"
export PROVISIONING_MODEL="SPOT"      # or "STANDARD"
```

```sh
gcloud compute instances create $INSTANCE_NAME \
  --project=$PROJECT_ID \
  --zone=$ZONE \
  --machine-type=$MACHINE_TYPE \
  --scopes=$SCOPES \
  --create-disk=boot=yes,image-project=${IMAGE_PROJECT},image-family=${IMAGE_FAMILY},name=${DISK_NAME},size=${DISK_SIZE},type=${DISK_TYPE} \
  --provisioning-model=$PROVISIONING_MODEL
```

![image](https://github.com/susumuota/local-llm-setup/assets/1632335/be9f4954-7b30-466f-bcac-8fd1a8717b98)

![image](https://github.com/susumuota/local-llm-setup/assets/1632335/e2465395-810b-4e56-ba2e-c4af9aae5398)

- instance with GPU

```sh
export PROJECT_ID="local-llm-setup-2"
export ZONE="us-central1-a"
export INSTANCE_NAME="instance-1"
export MACHINE_TYPE="g2-standard-4"   # for NVIDIA L4
export SCOPES="default,storage-full"
export IMAGE_PROJECT="ubuntu-os-cloud"
export IMAGE_FAMILY="ubuntu-2204-lts"
export DISK_NAME="disk-1"
export DISK_SIZE="100GB"
export DISK_TYPE="pd-ssd"
export ACCELERATOR="nvidia-l4"        # for NVIDIA L4
export PROVISIONING_MODEL="SPOT"      # or "STANDARD"
```

```sh
gcloud compute instances create $INSTANCE_NAME \
  --project=$PROJECT_ID \
  --zone=$ZONE \
  --machine-type=$MACHINE_TYPE \
  --scopes=$SCOPES \
  --create-disk=boot=yes,image-project=${IMAGE_PROJECT},image-family=${IMAGE_FAMILY},name=${DISK_NAME},size=${DISK_SIZE},type=${DISK_TYPE} \
  --accelerator=count=1,type=${ACCELERATOR} \
  --provisioning-model=$PROVISIONING_MODEL
```

```sh
# gcloud compute instances describe $INSTANCE_NAME --project=$PROJECT_ID --zone=$ZONE
# gcloud compute instances list --project=$PROJECT_ID
# gcloud compute instances delete $INSTANCE_NAME --project=$PROJECT_ID --zone=$ZONE
```

See the reference for more options.

- https://cloud.google.com/sdk/gcloud/reference/compute/instances/create

## Connect to the instance

Open a terminal on your local machine.

Optional: Add the private key to the ssh-agent.

```sh
ssh-add ~/.ssh/google_compute_engine
```

Connect to the instance.

```sh
gcloud compute ssh $INSTANCE_NAME --project=$PROJECT_ID --zone=$ZONE
```

For port forwarding.

```sh
gcloud compute ssh $INSTANCE_NAME --project=$PROJECT_ID --zone=$ZONE -- -L 8888:localhost:8888
```

See the reference for more options. e.g. port forwarding.

- https://cloud.google.com/solutions/connecting-securely#port-forwarding-over-ssh

## Run LLM without GPU

```sh
sudo apt-get update && sudo apt-get install -y aria2 build-essential git cmake
git clone https://github.com/susumuota/local-llm-setup.git
bash local-llm-setup/gce/create_dotfiles.sh
screen
cd local-llm-setup
```

- guanaco-65B (best 65B model)

This works ~ 2 tokens per second.

```sh
bash download_from_hf.sh https://huggingface.co/TheBloke/guanaco-65B-GGML/blob/main/guanaco-65B.ggmlv3.q5_K_M.bin
git clone https://github.com/ggerganov/llama.cpp
cd llama.cpp
make
./main -t 16 -c 2048 -i --color -e \
  -m "../guanaco-65B.ggmlv3.q5_K_M.bin" \
  -r "### Human:" --in-prefix " " --in-suffix "### Assistant:" \
  -p "A chat between a curious user and an artificial intelligence assistant. The assistant gives helpful, detailed, and polite answers to the user's questions.\n\n### Human: Hello\n### Assistant: Hi\n### Human: How are you?\n### Assistant:"
```

- falcon-40b-instruct (Overall best model, 40B)

This works ~ 3 tokens per second.

> **Note: I don't know why, but `falcon_main` doesn't work with `-r` option. So it seems impossible to use interactive mode `-i` at the moment.**

```sh
bash download_from_hf.sh https://huggingface.co/TheBloke/falcon-40b-instruct-GGML/resolve/main/falcon40b-instruct.ggmlv3.q6_K.bin
git clone https://github.com/cmp-nct/ggllm.cpp.git  # not llama.cpp
cd ggllm.cpp
rm -rf build; mkdir build; cd build
cmake -DLLAMA_CUBLAS=0 ..  # if you don't have CUDA
cmake --build . --config Release
./bin/falcon_main -t 16 -c 2048 --color -e \
  -m "../../falcon40b-instruct.ggmlv3.q6_K.bin" \
  -p "A chat between a curious user and an artificial intelligence assistant. The assistant gives helpful, detailed, and polite answers to the user's questions.\n\n### Human: Hello\n### Assistant: Hi\n### Human: How are you?\n### Assistant: I'm fine. Thank you.\n### Human: I want you to act as a storyteller. Tell me a science fiction story which is inspired by the Fermi Paradox and the Great Filter Hypothesis.\n### Assistant:"
```

- 30b-Lazarus (best 30B model)

This works ~ 4 tokens per second.

```sh
bash download_from_hf.sh https://huggingface.co/TheBloke/30B-Lazarus-GGML/blob/main/30b-Lazarus.ggmlv3.q6_K.bin
git clone https://github.com/ggerganov/llama.cpp
cd llama.cpp
make
./main -t 16 -c 2048 -i --color -e \
  -m "../30b-Lazarus.ggmlv3.q6_K.bin" \
  -r "### Human:" --in-prefix " " --in-suffix "### Assistant:" \
  -p "A chat between a curious user and an artificial intelligence assistant. The assistant gives helpful, detailed, and polite answers to the user's questions.\n\n### Human: Hello\n### Assistant: Hi\n### Human: How are you?\n### Assistant:"
```

## Run LLM with GPU

### Install CUDA drivers

```sh
git clone https://github.com/susumuota/local-llm-setup.git
bash local-llm-setup/gce/create_dotfiles.sh
bash local-llm-setup/gce/install_cuda_drivers.sh
sudo reboot
# and ssh again
```

Start `screen`. Sometimes ssh connection gets lost. You can recover session with `screen -r`.

```sh
screen
```

TODO

## Delete the instance

Delete the instance.

```sh
gcloud compute instances delete $INSTANCE_NAME --project=$PROJECT_ID --zone=$ZONE
gcloud compute instances list --project=$PROJECT_ID
```

## Delete the project

Delete the project if you don't need it to avoid any unexpected charges.

```sh
gcloud projects delete $PROJECT_ID
gcloud projects list
```

That's all.

## Author

Susumu OTA
