# personal-notes

* Personal notes taken from Terraform training. Will be maintained in the local private repo asides clone of the project.
* The folder "z-serdar-playground" will be used for not only this but other files as well -- in case some other custom code or artifacts will be needed to be created during the training.

# random
* Terraform is to manage the entire infrastructure, like the cloud workload in AWS. While Ansible, is to install and configure the software installed in that infrastructure. So, infrastructure automation can be done through AWS APIs via Terraform, where after the servers are provisioned; system config can be done via ansible.
* For Windows ssh compatibility: Putty for ssh connection to a host and puttygen for creating keys for connectivity
* Never forget to destroy a test deployment after lab is complete. Otherwise instances created will not be terminated and consumer from the 1 month uptime in the first free year free tier.
* .gitignore to ignore all runtime generated artifacts, cache, log etc is quite important. Also, required while avoiding the transfer of secrets into public repo.
* Ansible (or other software provisioning automation tool) can be integrated with Terraform. First infrastructure is created with terraform and then the method to integrate can be different per tool e.g. Chef scripts can be used within terraform files, or with Ansible the out file of terraform can be used to provision the instances created
* If due to some reason the software provisioning fails during an terraform apply, the instance and other resources creation still goes through (even though the operation is exited with an error alert) and resource creation is not rolled back. This is a watchpoint.
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
        * As always in architecture there is no right or wrong here, but purpose-driven decisions by weighing tradeoffs fitting the use-case and prioritizing the boundaries of exposed capabilities.
    * As in the architecture styles, Environment is the other factor while deciding how to manage an IaC stack. Environmental variety of the same IaC stack shapes around Delivery needs and Production needs.
        * Following the delivery pipeline of a project, IaC might have test staging and production stacks.
        * Also, production needs raised from fault tolerance, scalability, and isolation needs (single tenant/multi tenant); might result in multiple instances of an IaC stack
        * Pattern: Reusable stack >> instantiating the stack instance=, which is a single stack definition managed in one project with an environment variable (string, number, or listmaps)
            * Configuring the instances per environment is another pattern called Wrapper Project.
        * Antipatterns: Copy of the stack (may result in drift, verbose testing, consistency failure); multi-environment managed in one stack project
        * 





