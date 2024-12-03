#!/bin/bash

# Script to create AWS SSM parameters from a CSV file
# Author: Buddhima U
# Date: 03/12/2024
# Description: This script reads parameters from a CSV file and creates them in AWS Systems Manager Parameter Store.

# ============================
# Configuration Section
# ============================

# Specify the AWS region where the SSM parameters will be created
AWS_REGION="us-east-1"

# Path to the input CSV file
CSV_FILE="parameters.csv"

# ============================
# Functions Section
# ============================

# Function to validate dependencies
validate_dependencies() {
  if ! command -v aws &>/dev/null; then
    echo "Error: AWS CLI is not installed. Please install AWS CLI to use this script."
    exit 1
  fi

  if ! command -v awk &>/dev/null; then
    echo "Error: awk is not installed. Please install awk to use this script."
    exit 1
  fi
}

# Function to create an SSM parameter
create_ssm_parameter() {
  local name="$1"
  local type="$2"
  local value="$3"

  # Create the parameter using AWS CLI
  echo "Creating parameter: $name (Type: $type)"
  aws ssm put-parameter \
    --name "$name" \
    --type "$type" \
    --value "$value" \
    --overwrite \
    --region "$AWS_REGION" &>/dev/null

  if [ $? -eq 0 ]; then
    echo "Successfully created: $name"
  else
    echo "Failed to create: $name"
  fi
}

# ============================
# Main Script Execution
# ============================

# Step 1: Validate dependencies
validate_dependencies

# Step 2: Validate the CSV file
if [ ! -f "$CSV_FILE" ]; then
  echo "Error: CSV file '$CSV_FILE' not found."
  exit 1
fi

# Step 3: Read the CSV file and create parameters
echo "Processing parameters from $CSV_FILE..."

# Skip the header row and process each line
tail -n +2 "$CSV_FILE" | while IFS=',' read -r name type value; do
  # Trim whitespace (if any)
  name=$(echo "$name" | awk '{$1=$1;print}')
  type=$(echo "$type" | awk '{$1=$1;print}')
  value=$(echo "$value" | awk '{$1=$1;print}')

  # Call the function to create the parameter
  create_ssm_parameter "$name" "$type" "$value"
done

# Script completed
echo "All parameters processed."
