# **AWS SSM Parameter Creation Script**

## **Overview**
This script automates the creation of AWS Systems Manager (SSM) parameters from a CSV file. It reads parameter names, types, and values from the input file and creates them in the specified AWS region. This is particularly useful for managing large sets of configuration values, such as application secrets or runtime settings, in a structured and automated way.

---

## **Features**
- Reads parameters dynamically from a **CSV file**.
- Supports `String`, `SecureString`, and `StringList` parameter types.
- Automatically trims whitespace to prevent errors.
- Validates dependencies (e.g., AWS CLI, `awk`).
- Provides success and failure feedback for each parameter.
- Easy to customize for different AWS regions and input formats.

---

## **Prerequisites**
Before running the script, ensure the following:

1. **AWS CLI**:
   - The AWS CLI must be installed and configured.
   - Install AWS CLI: [AWS CLI Installation Guide](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html).
   - Configure it with sufficient IAM permissions:
     - **Required Actions**: `ssm:PutParameter`, `ssm:ListParameters`, `kms:Encrypt` (for `SecureString`).

     ```bash
     aws configure
     ```

2. **Tools**:
   - Ensure `awk` is installed (default in most Linux/macOS environments).

3. **CSV File**:
   - Prepare a CSV file with the following format:
   - Note: You can customize any field as you wish
     ```csv
     Name,Type,Value
    /application_name/environment/Key1,SecureString,value1
     ```

---

## **Setup**

### **1. Clone the Repository**
Clone the repository to your local machine:
```bash
git clone https://github.com/your-repo/aws-ssm-parameter-script.git
cd aws-ssm-parameter-script
chmod +x create_ssm_parameters_from_csv.sh
./create_ssm_parameters_from_csv.sh

