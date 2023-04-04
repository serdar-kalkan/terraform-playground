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
* Application-driven infrastruce design includes creating the right application runtimes with the correct abstraction where infrastructue primitives (compute, storage, and networking) and other services are bundled together. This will allow application development teams to focus on their application rather than the infrastructure issues. Ways to create these runtimes could be creating Application servers, container clusters/application clusters, or FaaS (serverless code) -- where needs could be different per team. And it should be the goal of any platform team to create a solution for every specific need but creating abstracted solutions for different use-cases.
* One of the the best practices for Terraform project structure is to have completely separated project directories for development and production. For increased quality and ease of testing, and also for complete isolation it is advised to have multiple AWS accounts: one for test, one for prod, and for billing (AWS organizations).
* A good tech stack for baking custom AMIs and creating infrastructure via automated ci/cd pipelines: 1) Packer for custom AMI creation (based on a sample AMI), 2) Ansible for server config (mainly cloud-init and userdata: installing/updating OS, adding app dependencies, fws, deploying custom apps etc) 3) Terraform for creating stack resources in the destination cloud platform
    * https://computingforgeeks.com/build-aws-ec2-machine-images-with-packer-and-ansible/
* In a usual SDLC cycle, IaC takes position in the relase stage where Provision and Deploy are IaC-related steps
    * [Developer] >> Build > Test > Release (Provision, Deploy) >> [EndUser]
    * This cycle can be a pipeline project rather than a freestlye workflow in an automated delivery software (like Jenkins), where release stage can be a merged stage including baking the server image and creating the tech stack

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
    * A module does not automatically outputs the stack elements created in that module to the root module (main.tf). Outputs need to be expplicity set.
* To be able to add resources created without Terraform in the cloud provider, you can use import command with the id of the resource e.g. instance id; to make those resources of the actual running terraform stack plan state. And then on they will continue to become a part of the plan.
* For simple load tests, there is tool called stres, which you can download once after you logged into the instance (ec2) that you want to test: 
    * sudo apt-get install stress // instals tool called stress
    * stress --cpu 2 --timeout 300 //stres the cpu (?) for 300 hundred seconds 
* Testing, and especially automated testing, is crucial in IaC. Offline testing (syntax validation, formatting/lintting and static code analysis, or testing against a mock API response set) and Online testing as a part of a delivery pipeline stage (test assertions to check existense, functionality and output of stack) by using 1) persistence test stacks (created once), 2) ephemeral test stack, 3) dual of both, 4) scheduled rebuild, 5) continuous stack (rebuilt everytime after each successful test and made ready for the next stage test) are some patterns. IaC can be useful in testing new IaC plans or making environment ready out of these patterns everytime new software code needs to be shipped. Orchestration of these testing strategies are critical via pipeline tools, by loosely coupling those tools via scripts rather than embedding logic.
    * Test assertions: Conditions of the test case e.g. given {} ... doThis {} ... where syntax could be different compared to this pseuodo code per automation framework or testing tool
    * Test fixtures: A static set of configuration, objects, data etc. that will help to execute tests when the component at the subject of testing is a provider or consumer type of component which means is dependent on upstream or downstream components/systems. I find this concept very similar to Pact/Contract driven testing
    * Out-of-band job: ...
* terraform console, helps to play around with interpolations in case there is a valid state (basically means, a terraform stack already applied) e.g. "the id of the instance launched is ${aws_instance.example.id}"
* To create stack elements by setting some variables during terraform apply the command prompt syntax is: terraform apply -var 'varkey=varvalue' (for macos). This comes handy when using a stack which excepts creationg time instructions like environment variables rather than a tfvars file (which overrules this prompt).
* State manipulation: It makes sense in some cases to manipulate existing stack's state created by Terraform: 1) State inspection: to see the list of resources created, but also to refresh state with the actual state of the resources declared in cloud platform, 2) Force re-creating: In case that a resource's definition is changed, Terraform automatically destroys and re-creates that resource the next time apply is executed. But in some cases, like server configuration (via cloud-init or local-exec or other provivisioner) is outdated in its content itself, there is a chance to "taint" that resource object even no change is visible to Terraform in this case (on the lower level), 3) Stop managing a resource via Terraform, 4) Disaster recovery: Forced pull or push of state file from or to a configured backend file/repo, in case DR is required manually.
* Managing drift in Terraform: There is no ootb feature in Terraform to update the original stack code config by taking the real world config as the source. Terraform commands (refresh, apply -refresh-only etc) are helpful to reconcile the code against the remote objects but takes the base from the source code, not the other way around. A way to do this would be to check the changes by refresh, and then do the changes manually. Also, import command only pulls the remote objects when they have not been in terraform tracking before. BUT, import does not create the reverse engineered stack code for the newly created resources, creation as code has to be done manually.
    * Not valid for option where a DevOps team manages thousands of resources, so Terraformer, is an external tool (only for GCP) that can be looked into for reverse Terraforming: https://github.com/GoogleCloudPlatform/terraformer, https://cloudacademy.com/course/infrastructure-to-code-with-terraformer-1135/what-is-terraformer/

# TODO 
- Do the jenkines, packer, terraform demo! (Might take 4 hrs at least!)
