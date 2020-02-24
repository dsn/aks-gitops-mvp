Getting Started
===============

Pre-Reqs
-------------

Before creating AKS cluster, we need a service account. To store backend state in azure, we need a storage account, storage access key and a container. These pre-reqs can be satisfied by running files in pre-reqs folder. We can do it manually in azure portal as well as with az cli. Following instructions are for running files in pre-reqs:

- switch to pre-reqs directory
- run `az login` and login.
- create terraform.tfvars and override variables from variables.tfvars. Here's minimal terraform.tfvars:
```hcl
# Ideally, storage account should be in separate global resource group so you don't accidentally delete it with your cluster resource group
rg_name  = "global_resources"
location = "centralus"
backend_storage_account_name = "alphanumericUniqueName"
```
- run `terraform init`
- run `terraform apply -var-file=./terraform.tfvars`
- type `yes` when prompted

Once run, execute this:

`terraform output -json`

This will give us all required environment variables which we need to export before running files for creating AKS cluster.

Once done, export following:

```bash
export ARM_SUBSCRIPTION_ID="...";
export ARM_CLIENT_ID="...";
export ARM_CLIENT_SECRET="...";
export ARM_TENANT_ID="...";
export ARM_ACCESS_KEY="..."
```
Creating Cluster
-------------------

Once we have above environment variables exported, switch to production/`<region>`/ and create .tfvars file. Minimum .tfvars will look like this:

```hcl
ssh_public_key       = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDDT9ZaOjaHcvO6icvPedgy73mxKpzGOU4U7rbXuyINGZNL0RSAjyJvHoB8Sm1xAgjrWKE4N58WOOOjW/EeNoP9m/aWDamDEawuV5B+2gpSIqliK9f3l7ssftB6pfl+/gqSpGu03QZ1BxtI1NTOCf447foXOtkqmmlnM1sswuo/XWvL/IEsTYCSOCju3nlyQPtruoO9bfT6kg4CnUmML9HIw7JsDAZceVV83iVY01KU13uFF1KETvxDvn9YABX1Cyx7yKRVsKJkj7dgndyCAu52qi6erD7wAKKMIoKTJbkCVExjHlXOd6WBq0A3azpel0ZOH+autcQ/e0R6m4MOj+7D test@Macbook-Pro.local"
service_principal_id = "57412d74-16d7-4cb2-9129-1a7695ed9941"
resource_group_name  = "aks-gitops-test"
cluster_name         = "aks-production"
prefix               = "production"
```

We need to export service_principal_secret as well which can be done with environment variable like this:

```bash
export TF_VARS_service_principal_secret=$ARM_CLIENT_SECRET
```

For backend configuration, edit backend.tfvars and put appropriate values which were output from pre-reqs.

Now run `terraform init -backend-config=./backend.tfvars`

Once backend is initialized, run following:

`terraform apply -var-file=./terraform.tfvars`


Once cluster is created, a file names kube_config is written to ./output folder. You can run following to connect to newly created cluster:

```bash
export KUBECONFIG=$( pwd )/output/kube_config
kubectl get pods
```
