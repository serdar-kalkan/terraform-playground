# personal-notes

* Personal notes taken from Terraform training. Will be maintained in the local private repo asides clone of the project.
* The folder "z-serdar-playground" will be used for not only this but other files as well -- in case some other custom code or artifacts will be needed to be created during the training.

# random
* Terraform is to manage the entire infrastructure, like the cloud workload in AWS. While Ansible, is to install and configure the software installed in that infrastructure. So, infrastructure automation can be done through AWS APIs via Terraform, where after the servers are provisioned; system config can be done via ansible.
* For Windows ssh compatibility: Putty for ssh connection to a host and puttygen for creating keys for connectivity
* Never forget to destroy a test deployment after lab is complete. Otherwise instances created will not be terminated and consumer from the 1 month uptime in the first free year free tier.
* .gitignore to ignore all runtime generated artifacts, cache, log etc is quite important. Also, required while avoiding the transfer of secrets into public repo.

