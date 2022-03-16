# personal-notes

* Personal notes taken from Terraform training. Will be maintained in the local private repo asides clone of the project.
* The folder "z-serdar-playground" will be used for not only this but other files as well -- in case some other custom code or artifacts will be needed to be created during the training.

# theory
* Terraform is to manage the entire infrastructure, like the cloud workload in AWS. While Ansible, is to install and configure the software installed in that infrastructure. So, infrastructure automation can be done through AWS APIs via Terraform, where after the servers are provisioned; system config can be done via ansible.
* Ansible (or other software provisioning automation tool) can be integrated with Terraform. First infrastructure is created with terraform and then the method to integrate can be different per tool e.g. Chef scripts can be used within terraform files, or with Ansible the out file of terraform can be used to provision the instances created
* Infrastruce systems (like an IaaS) have 3 layers: 
    * Applications layer: app packages/instance, container instance, serverless code (function)
    * Application runtime layer: virtual machine, operating sys, container (cluster), serverless code execution environment
    * Core Infrastructure platforms: compute, storage, network
    * Elements in the 3rd layer can also be used to label types of higher level infrastructure resources in layer 2 (compute: server/vms, server clusters aka auto scaling groups, serverless services, managed container services, container clusters (EKS); storage: DBaaS as structured storage)
    * Main goal of IaC is to use code to manage (plan, deploy, destroy, change, start, stop, etc in a CI/CD manner) layer 3 and recursively 2, to create application runtime environments ready for applications (which are actual business capabilities) consumption. This will eventually enable 4 key metrics of high performance to become a reality in the team:
        1. Delivery Lead Time: Total time elapsed to ship code
        2. Deployment frequency: How often code is deployed in the production environment
        3. Change fail percentage: Ratio of failed relaeases against whole
        4. MTTR: Mean time to recover from outages based on a min or even sec level depending on applications criticality
* IaC Architecture styles for "stack" management, with increased specificty
    * Monolithic: All the resources and elements are defined in one single IaC project and maintained in the same repo, hence same proceses e.g. ci/cd etc
    * Apllication Grouping: Grouping of similar applications in same stack, under one project. Coarse grained monolith, has the risk to become monolith
    * Service: Hand in hand with Microservices software architecture pattern. One service per stack, maintained in its own project and repo and so on. Simplifies process for each service but increases overall complexity. Creating of purposeful abstractions for reusable parts via modules is a good pattern to enforce consistency.
    * Micro (service) stack: Resource type level seggragation of a given service e.g. a separate stack for each: compute, networking, storage (databsase). Might be meaningful when lifecycle of different elements vary and this variation holds a significant importance (like vm vs persistent database). Can create overhead, needs care.
    * As always in architecture decisions there is no right or wrong here, but purpose-driven decisions by weighing tradeoffs fitting the use-case and prioritizing the boundaries of exposed capabilities.
* As in the architecture styles, Environment is the other factor while deciding how to manage an IaC stack. Environmental variety of the same IaC stack shapes around Delivery needs and Production needs.
    * Following the delivery pipeline of a project, IaC might have test staging and production stacks.
    * Also, production needs raised from fault tolerance, scalability, and isolation needs (single tenant/multi tenant); might result in multiple instances of an IaC stack
    * Pattern: Reusable stack >> instantiating the stack instance=, which is a single stack definition managed in one project with an environment variable (string, number, or listmaps)
        * Configuring the instances per environment is another pattern called Wrapper Project.
    * Antipatterns: Copy-paste of the stack (may result in drift, verbose testing, consistency failure); multi-environment managed in one stack project
* 

# practice 
* After downloading terraform binary from official website, on Mac create env variable so terraform can be used in any folder or path >>
    * unzip (PATH).(FILE).zip
    * export PATH=/Users/DCCS/terraform/:$PATH
* For Windows ssh compatibility: Putty for ssh connection to a host and puttygen for creating keys for connectivity
* To create a private and public key pair on Mac, simply use ssh-keygen -f mykey. Useful when creating a poc for simply to connect the created ec2 instances after they are create via terraform stack apply
* Never forget to destroy a test deployment after lab is complete. Otherwise instances created will not be terminated and consumer from the 1 month uptime in the first free year free tier.
* .gitignore to ignore all runtime generated artifacts, cache, log etc is quite important. Also, required while avoiding the transfer of secrets into public repo.
* If due to some reason the software provisioning fails during an terraform apply, the instance and other resources creation still goes through (even though the operation is exited with an error alert) and resource creation is not rolled back. This is a watchpoint.
* "Modules" is an important concept while creating reusable terraform stack definitions e.g. for different environments or for different clients etc. A good lab: https://learn.hashicorp.com/tutorials/terraform/module-create
    * Advanced example of reusable modules with a lab: https://blog.gruntwork.io/how-to-create-reusable-infrastructure-with-terraform-modules-25526d65f73d
* To be able to add resources created without Terraform in the cloud provider, you can use import command with the id of the resource e.g. instance id; to make those resources of the actual running terraform stack plan state. And then on they will continue to become a part of the plan.
* For simple load tests, there is tool called stres, which you can download once after you logged into the instance (ec2) that you want to test: 
    * sudo apt-get install stress // instals tool called stress
    * stress --cpu 2 --timeout 300 //stres the cpu (?) for 300 hundred seconds 


