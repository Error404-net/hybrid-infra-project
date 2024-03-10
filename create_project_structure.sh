#!/bin/bash

# Define project directory
project_dir="hybrid-infra-project"

# Create directory structure
echo "Creating project structure..."
mkdir -p ${project_dir}/{ansible/inventory,ansible/playbooks,ansible/roles/common/{tasks,handlers,templates},terraform/{linode,proxmox,shared},scripts}

# Create .gitignore
cat <<EOF > ${project_dir}/.gitignore
*.tfstate
*.tfstate.backup
.terraform/
*.tfvars
*.retry
.vscode/
.idea/
*.swp
EOF

# Create README.md
cat <<EOF > ${project_dir}/README.md
# Hybrid Infrastructure Project

This project manages a hybrid infrastructure with Linode and Proxmox using Terraform and Ansible.

## Structure

- \`ansible/\`: Contains Ansible playbooks and roles.
- \`terraform/\`: Contains Terraform configurations for Linode and Proxmox.
- \`scripts/\`: Utility scripts.

## Usage

Update the Terraform and Ansible configurations according to your infrastructure, then apply the Terraform changes and run the Ansible playbooks.
EOF

# Terraform placeholders
echo "Creating Terraform placeholders..."
for provider in linode proxmox; do
  cat <<EOF > ${project_dir}/terraform/${provider}/main.tf
# Main Terraform configuration for ${provider}
EOF

  cat <<EOF > ${project_dir}/terraform/${provider}/variables.tf
# Variable definitions for ${provider}
EOF

  cat <<EOF > ${project_dir}/terraform/${provider}/outputs.tf
# Output definitions for ${provider}
EOF
done

cat <<EOF > ${project_dir}/terraform/shared/versions.tf
terraform {
  required_version = ">= 0.13"
}
EOF

# Ansible placeholders
echo "Creating Ansible placeholders..."
cat <<EOF > ${project_dir}/ansible/inventory/hosts.yaml
# Ansible inventory
all:
  children:
    linode:
      hosts:
    proxmox:
      hosts:
EOF

cat <<EOF > ${project_dir}/ansible/playbooks/site.yaml
# Main Ansible playbook
- hosts: all
  roles:
    - common
EOF

cat <<EOF > ${project_dir}/ansible/roles/common/tasks/main.yaml
# Common role tasks
EOF

# Scripts
echo "Creating utility script placeholders..."
cat <<EOF > ${project_dir}/scripts/generate_inventory.sh
#!/bin/bash
# Script to generate Ansible inventory from Terraform state
EOF

# Making scripts executable
chmod +x ${project_dir}/scripts/generate_inventory.sh

echo "Project structure created successfully."

