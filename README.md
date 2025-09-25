# hcp_demo

## notes

A workspace in HCP Terraform represents your Terraform configuration, a single state file, and your variable values. When you perform a Terraform operation, the HCP Terraform runs the Terraform operation and reports the progress. You can configure your workspace to use one of the following workflows:

VCS-driven workflow: HCP Terraform fetches your configuration from your version control repository and automatically starts plan and apply operations whenever you make changes to the repository. This keeps your repository as the single source of truth for the workspace.

https://developer.hashicorp.com/terraform/tutorials/cloud-get-started/cloud-create-vcs-workspace


