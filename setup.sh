#!/usr/bin/env bash
source setup.inc.sh

# Check if required binaries are present/in the PATH variable
function check_requirements {
  echo "Checking existence of required binaries: $REQUIREMENTS"
  NOTFOUND=false

  for i in $REQUIREMENTS; do
    which $i > /dev/null && echo "$i found" || { echo "$i not found in PATH"; NOTFOUND=true; }
  done

  if [[ "$NOTFOUND" == "true" ]]; then
    echo "Please install and/or add unmet requirements to the PATH variable and try again"
    exit 1
  else
    echo "All requirements met"
  fi
}

# Create a Service Principal to be used by GH Actions or similar CI solutions
# First we check for existence of CI/CD secrets file and skip if found
function create_service_principal {
  echo "Checking if previous CI/CD secrets file exists"

  if [[ -f "$CI_CD_SECRETS_FILE" ]]; then
    echo "Found file "$CI_CD_SECRETS_FILE", skipping creation of Service Principal"
  else
    echo "No previous CI/CD secrets file found"
    echo "Retrieving Subscription ID"
    AZ_SUB=$(az account show --query id --output tsv)
    echo "Creating Service Principal for CI/CD"
    AZ_AD_SP_OUTPUT=$(az ad sp create-for-rbac \
      --name "$PROJECT_NAME-sp" \
      --role contributor \
      --scopes /subscriptions/$AZ_SUB \
      --sdk-auth \
    )

    if [[ $? -eq 0 ]]; then
      echo "Service Principal for CI/CD created successfully"
      echo "Saving Service Principal authentication details as $CI_CD_SECRETS_FILE"
      echo "$AZ_AD_SP_OUTPUT" > $CI_CD_SECRETS_FILE
      echo "JSON file saved successfully. You may copy the contents into a secret in your CI solution"
    else
      echo "Error creating Service Principal for CI/CD"
      exit 2
    fi
  fi
}

# Create Resource Group for the Terraform state storage
function create_tfstate_storage_rg {
  echo "Creating Resource Group $TFSTATE_STORAGE_RG in region $PROJECT_REGION"
  az group create -l $PROJECT_REGION -n $TFSTATE_STORAGE_RG

  if [[ $? -eq 0 ]]; then
    echo "Resource Group created successfully"
  else
    echo "Error creating Resource Group"
  exit 3
  fi
}

# Create Storage Account for the Terraform state file
function create_tfstate_sa {
  echo "Creating Terraform state Storage Account $TFSTATE_STORAGE_ACCOUNT"
  az storage account create -n $TFSTATE_STORAGE_ACCOUNT -g $TFSTATE_STORAGE_RG -l $PROJECT_REGION --sku Standard_LRS

  if [[ $? -eq 0 ]]; then
    echo "Storage Account created successfully"
  else
    echo "Error creating Storage Account"
    exit 4
  fi
}

# Create Storage Container for the Terraform state file
function create_tfstate_sc {
  echo "Creating Terraform state Storage Container $TFSTATE_STORAGE_CONTAINER"
  az storage container create --name $TFSTATE_STORAGE_CONTAINER --account-name $TFSTATE_STORAGE_ACCOUNT

  if [[ $? -eq 0 ]]; then
    echo "Storage Container created successfully"
  else
    echo "Error creating Storage Container"
    exit 5
  fi
}

# First time setup
# It should not run inside GH Actions nor similar CI solutions
# Even when running locally, it should be idempotent
function first_time_setup {
  create_service_principal
  create_tfstate_storage_rg
  create_tfstate_sa
  create_tfstate_sc
}

# Run function to check requirements
check_requirements

# If not running in GH Actions, run function for first time setup
if [[ "$GITHUB_ACTIONS" != "true" ]]; then
  echo "Not inside GitHub Actions, running first time setup"
  first_time_setup
fi
