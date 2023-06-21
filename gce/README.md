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
# unset PROJECT_ID
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
# unset REGION ZONE
```

## Create an instance

Create an instance specifying the machine type, OS, disk, GPU, etc.

`SCOPES` specify GCP services that the instance can access. e.g. `storage-full` for GCS.

- instance without GPU

```sh
export INSTANCE_NAME="instance-1"
export MACHINE_TYPE="c2-standard-16"   # vCPU: 16, RAM: 64GB. need to increase quota `c2_cpus` from `8` to `16`.
export SCOPES="default,storage-full"
export IMAGE_PROJECT="ubuntu-os-cloud"
export IMAGE_FAMILY="ubuntu-2204-lts"
export DISK_NAME="disk-1"
export DISK_SIZE="100GB"
export DISK_TYPE="pd-ssd"
export PROVISIONING_MODEL="SPOT"      # or "STANDARD"
gcloud compute instances create $INSTANCE_NAME \
  --project=$PROJECT_ID \
  --zone=$ZONE \
  --machine-type=$MACHINE_TYPE \
  --scopes=$SCOPES \
  --create-disk=boot=yes,image-project=${IMAGE_PROJECT},image-family=${IMAGE_FAMILY},name=${DISK_NAME},size=${DISK_SIZE},type=${DISK_TYPE} \
  --provisioning-model=$PROVISIONING_MODEL
gcloud compute instances describe $INSTANCE_NAME --project=$PROJECT_ID --zone=$ZONE
gcloud compute instances list --project=$PROJECT_ID
# gcloud compute instances delete $INSTANCE_NAME --project=$PROJECT_ID --zone=$ZONE
# unset INSTANCE_NAME MACHINE_TYPE SCOPES
```

![image](https://github.com/susumuota/local-llm-setup/assets/1632335/be9f4954-7b30-466f-bcac-8fd1a8717b98)

![image](https://github.com/susumuota/local-llm-setup/assets/1632335/e2465395-810b-4e56-ba2e-c4af9aae5398)

- instance with GPU

```sh
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
gcloud compute instances create $INSTANCE_NAME \
  --project=$PROJECT_ID \
  --zone=$ZONE \
  --machine-type=$MACHINE_TYPE \
  --scopes=$SCOPES \
  --create-disk=boot=yes,image-project=${IMAGE_PROJECT},image-family=${IMAGE_FAMILY},name=${DISK_NAME},size=${DISK_SIZE},type=${DISK_TYPE} \
  --accelerator=count=1,type=${ACCELERATOR} \
  --provisioning-model=$PROVISIONING_MODEL
gcloud compute instances describe $INSTANCE_NAME --project=$PROJECT_ID --zone=$ZONE
gcloud compute instances list --project=$PROJECT_ID
# gcloud compute instances delete $INSTANCE_NAME --project=$PROJECT_ID --zone=$ZONE
# unset INSTANCE_NAME MACHINE_TYPE SCOPES
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
gcloud compute ssh $INSTANCE_NAME --project=$PROJECT_ID --zone=$ZONE -- -L 7860:localhost:7860
```

See the reference for more options. e.g. port forwarding.

- https://cloud.google.com/solutions/connecting-securely#port-forwarding-over-ssh

## Run LLM without GPU

- guanaco-65B (best 65B model)

```sh
sudo apt-get update && sudo apt-get install -y aria2 build-essential git
git clone https://github.com/ggerganov/llama.cpp.git
cd llama.cpp
make
aria2c -x 5 "https://huggingface.co/TheBloke/guanaco-65B-GGML/resolve/main/guanaco-65B.ggmlv3.q5_K_M.bin" -d "models" -o "guanaco-65B.ggmlv3.q5_K_M.bin"
./main -t 16 -m "models/guanaco-65B.ggmlv3.q5_K_M.bin" --color -c 2048 -i -r "### Human: " -e -p "A chat between a curious user and an artificial intelligence assistant. The assistant gives helpful, detailed, and polite answers to the user's questions.\n\n### Human: Hello\n### Assistant: Hi\n### Human: How are you?\n### Assistant:"
```

- 30b-Lazarus (best 30B model)

```sh
aria2c -x 5 "https://huggingface.co/TheBloke/30B-Lazarus-GGML/resolve/main/30b-Lazarus.ggmlv3.q6_K.bin" -d "models" -o "30b-Lazarus.ggmlv3.q6_K.bin"
./main -t 16 -m "models/30b-Lazarus.ggmlv3.q6_K.bin" --color -c 2048 -i -r "### Human: " -e -p "A chat between a curious user and an artificial intelligence assistant. The assistant gives helpful, detailed, and polite answers to the user's questions.\n\n### Human: Hello\n### Assistant: Hi\n### Human: How are you?\n### Assistant:"
```

## Run LLM with GPU

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
