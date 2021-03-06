
![production-centralus-apply](https://github.com/haisumb/aks-gitops-mvp/workflows/production-centralus-apply/badge.svg)

Getting Started
===============

Pre-Reqs
-------------

Before creating AKS cluster, we need a service account for accessing backend state and another service account for cluster itself. To store backend state in azure, we need an storage account, one storage access key and a container. Following instructions are for doing it with az cli command.

### Setup ENV vars:

Modify following vars with appropriate values for your use:

```bash
STORAGE_ACCOUNT_NAME=aksgitopsmvp32423
STORAGE_CONTAINER_NAME=aksgitopsmvpcontainer
GLOBAL_RG_NAME=gitops-rg-aks-mvp-global
GLOBAL_RG_LOCATION=centralus
RG_NAME=gitops-rg-aks-mvp
LOCATION=centralus
```

Login using `az login` command on cli.

### Resource group creation

```bash
# create global rg:
az group create -l "${GLOBAL_RG_LOCATION}" -n "${GLOBAL_RG_NAME}"
# create cluster rg:
az group create -l "${LOCATION}" -n "${RG_NAME}"
```

### Service account creation

run following command:

`az group show -n ${RG_NAME}`

Copy subscription id from id field and put it in following var:

```bash
# example value, please modify
SUBSCRIPTIONID=d09f2342-eae7-4c34-234e-08154540c034
```

Now create one subscription level service account which will be able to access both global resource group and cluster resource group:

```bash
az ad sp create-for-rbac --role contributor --scopes /subscriptions/${SUBSCRIPTIONID}
```
Output should look like:

```json
{
  "appId": "...",
  "displayName": "azure-cli-2020-02-25-15-54-33",
  "name": "http://azure-cli-2020-02-25-15-54-33",
  "password": "...",
  "tenant": "..."
}
```

Now copy above values and export following in CD pipeline or terminal:

```bash
# value of $SUBSCRIPTIONID, appId, password and tenant
export ARM_SUBSCRIPTION_ID="..";
export ARM_CLIENT_ID="...";
export ARM_CLIENT_SECRET="...";
export ARM_TENANT_ID="...";
```

Now create another service principal, restricted to cluster resource group:

```bash
az ad sp create-for-rbac --role contributor --scopes /subscriptions/${SUBSCRIPTIONID}/resourceGroups/${RG_NAME}
```

Output should look like:

```json
{
  "appId": "...",
  "displayName": "azure-cli-2020-02-25-15-54-33",
  "name": "http://azure-cli-2020-02-25-15-54-33",
  "password": "...",
  "tenant": "..."
}
```

export these environment variables from output:

```bash
# value of appId and password
export TF_VAR_aks_service_principal_id=ea8ccce3-6a2a-4cd1-872c-754c22d19a44
export TF_VAR_aks_service_principal_secret=bdce81b8-5767-4401-a639-beee9ae05685
```

### Generate private key

Generate a private key using ssh-keygen command then put public key in following env var:

```bash
export TF_VAR_ssh_public_key="contents of .pub file here"
```

This can be used if you want to ssh into cluster nodes.

### Storage account creation

```bash
az storage account create \
    --name "${STORAGE_ACCOUNT_NAME}" \
    --resource-group "${GLOBAL_RG_NAME}" \
    --location centralus \
    --sku Standard_LRS \
    --encryption-services blob


az storage account keys list \
    --account-name "${STORAGE_ACCOUNT_NAME}" \
    --resource-group "${GLOBAL_RG_NAME}" \
    --output table
```

#### Create container

Put key output in above in key env var and run following:

```bash
export AZURE_STORAGE_ACCOUNT="$STORAGE_ACCOUNT_NAME"
export AZURE_STORAGE_KEY="one of keys output from az storage account keys list command"
az storage container create --name "${STORAGE_CONTAINER_NAME}"
# storage access key:
export ARM_ACCESS_KEY="$AZURE_STORAGE_KEY"
```

### Setting up backend

Modify backend.tfvars and put values like this:

```hcl
storage_account_name = "aksgitopsmvp32423"
container_name       = "aksgitopsmvpcontainer"
key                  = "centralus-production-tfstate"
resource_group_name  = "gitops-rg-aks-mvp-global"
```
Modify terraform.tfvars file like this:

```hcl
resource_group_name = "gitops-rg-aks-mvp"
cluster_name        = "centralus-production-aks"
prefix              = "centralusproduction"
```

### Setting up RBAC with Azure Active Directory

Follow instructions on [Integrate Azure Active Directory with Azure Kubernetes Service using the Azure CLI](https://docs.microsoft.com/en-us/azure/aks/azure-ad-integration-cli) before "Deploy The Cluster" section. You should have client app id, server app id and server app secret once you are done with these instructions. Please export these values in following variables:

```bash
export TF_VAR_active_directory_client_app_id     = "..."
export TF_VAR_active_directory_server_app_id     = "..."
export TF_VAR_active_directory_server_app_secret = "..."
```

Running manifests for cluster creation
-----------------------

Once above setup is complete, you can run following to init and apply:

terraform init -backed-config=./backend.tfvars

terraform apply -var-file=./terraform.tfvars


Env vars required for CD pipeline
----------------------

You need at least following env vars for a pipeline:

- ARM_SUBSCRIPTION_ID
- ARM_CLIENT_ID
- ARM_CLIENT_SECRET
- ARM_TENANT_ID
- TF_VAR_aks_service_principal_id
- TF_VAR_aks_service_principal_secret
- TF_VAR_ssh_public_key
- ARM_ACCESS_KEY

You will also need following if you want to use RBAC with Azure AD:

- TF_VAR_active_directory_client_app_id
- TF_VAR_active_directory_server_app_id
- TF_VAR_active_directory_server_app_secret

Accessing the cluster with kubectl
----------------------------------

Once cluster is created, a file names kube_config is written to ./output folder. You can run following to connect to newly created cluster:

```bash
export KUBECONFIG=$( pwd )/output/kube_config
kubectl get pods
```

NOTE: This file is for admins and contains maximum privillege, it's not recommended to share this with everyone.

### Using RBAC with Azure Active Directory to access cluster

Create groups in Azure AD and add users to groups by following instructions at https://docs.microsoft.com/en-us/azure/aks/azure-ad-rbac.

Once groups/users are setup in Azure AD, you need to create corresponding roles and role bindings in cluster. Use following command to get admin KUBECONFIG:

```bash 
unset KUBECONFIG
az aks get-credentials --resource-group "myAKSResourceGroup" --name "aks-cluster-name" --admin
```
A ClusterRole and ClusterRoleBinding are cluster level permissisons. Users in associated group will have permissions to perform all allowed actions on all allowed namespaces. If you want to restrict users to particular namespaces, use Role and RoleBinding. 

As an example, we will create a role for dev namespace with full privilleges. For more information and examples you can see https://docs.microsoft.com/en-us/azure/aks/azure-ad-rbac.

Create yaml file called role-dev-namespace.yaml and put following:

```yaml
kind: Role
apiVersion: rbac.authorization.k8s.io/v1beta1
metadata:
  name: dev-user-full-access
  namespace: dev
rules:
- apiGroups: ["", "extensions", "apps"]
  resources: ["*"]
  verbs: ["*"]
- apiGroups: ["batch"]
  resources:
  - jobs
  - cronjobs
  verbs: ["*"]
```
Now run

`kubectl apply -f role-dev-namespace.yaml`

Get group id for the group you want to associate this role with, using following command:

`az ad group show --group groupNameHere --query objectId -o tsv`

 Create a file named rolebinding-dev-namespace.yaml and paste the following YAML manifest. On the last line, replace groupObjectId with the group object ID output from the previous command:

```yaml
kind: RoleBinding
apiVersion: rbac.authorization.k8s.io/v1beta1
metadata:
  name: dev-user-access
  namespace: dev
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: Role
  name: dev-user-full-access
subjects:
- kind: Group
  namespace: dev
  name: groupObjectId
 ```

 Now users in this group will be able to get a kubeconfig using following command:

`az aks get-credentials --resource-group myResourceGroup --name myAKSCluster --overwrite-existing`

Note: This replaces existing `~/.kube/config`. You can remove `--overwrite-existing` if you don't want that.

Now, when user runs a command like:

`kubectl run --generator=run-pod/v1 nginx-dev --image=nginx --namespace dev`

It will ask to login on browser. Once done, command will succesfully run. 
