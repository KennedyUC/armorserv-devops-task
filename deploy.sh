#!/bin/bash

# Configuration
FRONTEND_DIR="frontend"
BACKEND_DIR="backend"
LAMBDA_FUNCTION_NAME="node-backend"
ZIP_FILE="backend.zip"
LAMBDA_ALIAS="dev"

# Deploy Frontend
deploy_frontend() {
  echo "Deploying frontend..."
  cd $FRONTEND_DIR

  # Initialize Amplify and push
  amplify init --yes
  amplify push --yes

  amplify publish --yes
  echo "Frontend deployed."
}

# Deploy Backend
deploy_backend() {
  echo "Deploying backend..."
  cd $BACKEND_DIR

  # Zip lambda function files
  zip -r $ZIP_FILE .

  # Update Lambda function code
  aws lambda update-function-code --function-name $LAMBDA_FUNCTION_NAME --zip-file fileb://$ZIP_FILE

  # Publish a new version and update the alias
  VERSION=$(aws lambda publish-version --function-name $LAMBDA_FUNCTION_NAME --query 'Version' --output text)
  aws lambda update-alias --function-name $LAMBDA_FUNCTION_NAME --name $LAMBDA_ALIAS --function-version $VERSION

  echo "Backend deployed. Alias '$LAMBDA_ALIAS' now points to version $VERSION."
}

# Check CLI argument and call appropriate function
if [ "$1" == "frontend" ]; then
  deploy_frontend
elif [ "$1" == "backend" ]; then
  deploy_backend
else
  echo "Invalid argument. Use 'frontend' or 'backend'."
  exit 1
fi

echo "Deployment complete."