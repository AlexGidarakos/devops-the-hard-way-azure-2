# Change values in the following section at will 
PROJECT_BASENAME="devopshard"
PROJECT_PREFIX="alexg"
PROJECT_REGION="uksouth"

# If running in GH Actions, append "gh" to project prefix
if [[ "$GITHUB_ACTIONS" == "true" ]]; then
  PROJECT_PREFIX="${PROJECT_PREFIX}-gh"
fi

REQUIREMENTS="az terraform docker kubelogin kubectl"
PROJECT_NAME="${PROJECT_PREFIX}-${PROJECT_BASENAME}"
CI_CD_SECRETS_FILE="cicd-auth.gitignore.json"
AKS_AAD_GROUP="${PROJECT_NAME}-aks-group"
MAIN_RG="${PROJECT_NAME}-rg"
TFSTATE_STORAGE_RG="${PROJECT_NAME}-rg-tfstate"
TFSTATE_STORAGE_CONTAINER="${PROJECT_NAME}-tf"
TFSTATE_FILE="${PROJECT_NAME}.tfstate"

# Following var value MUST be max 24 chars and include only lowercase letters and numbers
TFSTATE_STORAGE_ACCOUNT=$(echo "${PROJECT_NAME}-tf" | tr -d "-")
TFSTATE_STORAGE_ACCOUNT=${TFSTATE_STORAGE_ACCOUNT:0:24}
