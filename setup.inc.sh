# Change values in the following section at will 
PROJECT_BASENAME="devopshard"
PROJECT_PREFIX="alexg"
PROJECT_REGION="uksouth"

# If running in GH Actions, append "gh" to project prefix
if [[ "$GITHUB_ACTIONS" == "true" ]]; then
  PROJECT_PREFIX="${PROJECT_PREFIX}-gh"
fi

REQUIREMENTS="az terraform docker kubelogin kubectl"
STORAGE_CONTAINER_NAME="tfstate"
TFSTATE_FILENAME="terraform.tfstate"
PROJECT_NAME="${PROJECT_PREFIX}$-{PROJECT_BASENAME}"
CI_CD_SECRETS_FILE="cicd-secrets-gitignore.json"
AKS_AAD_GROUP_NAME="$PROJECT_NAME-aks-group"
RESOURCE_GROUP_NAME="$PROJECT_NAME-rg"
TFSTATE_RESOURCE_GROUP_NAME="$PROJECT_NAME-tfstate-rg"

# Following var value MUST be max 24 chars and include only lowercase letters and numbers
STORAGE_ACCOUNT_NAME=$(echo "$PROJECT_NAME-tf" | tr -d "-")
STORAGE_ACCOUNT_NAME=${STORAGE_ACCOUNT_NAME:0:24}
