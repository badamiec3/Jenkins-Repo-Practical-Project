# CI Pipeline Practical Project

## Contents
* [Aims](#aims)
* [Architecture](#architecture)
* [CI Pipeline](#ci-pipeline)
* [Project Tracking](#project-tracking)
* [Testing](#testing)
* [Flask App](#flask-app)

## Aims
This project encapsulates the following concepts: 
* Continuous Integration
* Containerisation
* Configuration Management
* Cloud Solutions
* Infrastructure Management
* Orchestration

They are used to deploy an already provided simple Flask application comprising of two services in a microservice architecture. This application is deployed in a Continuous Intergation pipeline.

In order to achieve this, the following technologies are used:
* CI Server: Jenkins
* Containerisation: Docker
* Configuration Management: Ansible
* Cloud Solutions: AWS EC2, VPC, RDS ad EKS
* Infrastructure Management: Terraform
* Orchestration Tool: Kubernetes
* Reverse Proxy: NGINX

In addition, Git and GitHub were used as the version control system, and a Jira Kanban board was used for project planning.
The cloud and CI technologies utilised in the context of this project are described in more detail below. 

## Architecture
Pictured below is the architecture utilised for the project.

![architecture][architecture]

The 'install' ec2 VM and the 'pytest' ec2 VM were launched manually using the root user AWS console. Terraform and Ansible running on the 'install' VM were then used to deploy a 'jenkins' VM, two MySQL RDS instances, as well as an EKS Cluster. 

### Terraform
Terraform is an Infrastructure Management tool which allows developers to control the infrastructure of the cloud service provider, and is an example of Infrastructure as Code. Terraform is often used to deploy staging and test environments due to the ease with which it can be utilised to mimic production environments. It is also widely used to deploy infrastructure across more than one cloud provider simultaneously. In the scope of this project it is used to deploy an ec2 instance to run the CI Server Jenkins, an EKS Cluster which hosts the containerised Flask application using the Orchestration Tool Kubernetes, an RDS instance to provide a database for the application in the live environment, and another RDS instance which the pytest VM connects to in order to run tests.

### Ansible
Ansible is an open-source Configuration Management tool which can provision and manage software across host nodes. In this project it was used to install the required software and packages on the jenkins VM and the pytest VM. 

The software installed on the jenkins VM was as follows:
* Docker and docker-compose
* kubectl
* Jenkins
* AWS CLI
* MySQL
* Git

The software installed on the pytest VM was as follows:
* Docker and docker-compose
* pytest
* MySQL

## CI Pipeline

Below is an image showing the Continuous Integration pipeline used to deploy and continuously configure the Flask application.

![pipeline][pipeline]

This pipeline allows for rapid and simple development-to-deployment by automating the integration process. Code can be produced and pushed to GitHub, which will automatically push the new code to Jenkins via a webhook trigger. From there, tests are automatically run in a separate testing environment from the live cluster, and other build stages performed.

### Jenkins

When a change is made to the source code, the git repository is pulled by Jenkins and appropriate pytests are performed to ensure the application will function correctly. If the tests pass, docker images of the frontend and backend are built and pushed to Docker Hub. They are then pulled down with Kubernetes and changes are applied to the Docker containers hosted on a Kubernetes cluster in a live environment.  

This process is automated by a Jenkins pipeline job with distinct build stages. If a build stage fails, the subsequent stages are not executed and the job will fail altogether, providing detailed console outputs.

The main build stages in this project are:
* Pulling code from a Git respository after a web hook trigger
* Running pytests 
* Upon succesful testing, building docker images and pushing them to Docker Hub 
* Configuring the Docker containers running in a Kubernetes cluster

A typical job build is shown below.

![jenkins][jenkins]

## Project Planning and Tracking
A Jira Kanban board was used to plan and track the progress of the project. While this type of project tracking software is usually used for projects involving user stories, in the context of this project it was a highly useful tool to break down the deployment of the CI pipeline into smaller technical steps. 

Below are pictured the epics associated with the project, as well as a burndown chart for one of the four sprints.
![kanban][kanban]

![burndown][burndown]

The link to the board is found here: https://badamiec.atlassian.net/jira/software/projects/PPCP/boards/4/roadmap

Past sprints and burndown charts can be accessed in the Reports section along with past issues, child issues and estimated story points. 

## Testing
An important step in the CI pipeline is testing. The Jenkins pipeline in this project is designed in such a way that when a change is made to the source code, tests are ran and must succeed in order for the pipeline to proceed with the building and pushing of updated docker images to Docker Hub. 
Pytest is used to run the tests on the app. Tests were provided for both the backend and frontend of the flask app, and pytest generated a coverage report as a console output (pictured below) which informed the developer about how many tests failed and how many passed.

Successful frontend report:

![frontendtest][frontendtest]

Successful backend report:

![backendtest][backendtest]

The testing stages make use of the '| grep passed' command, with the standard output of the pytest piped into it, and the fact that a Jenkins pipeline stage will fail if the last console command in the stage is unsuccessful. If the test fails in either the backend or the frontend, the grep command will not find any line containing 'passed' and will instead show FAILURES, causing the pipeline to skip the later steps. No updated images are pushed to Docker Hub and the Kubernetes cluster pods and services are not configured. A failed test coverage report is shown below. 

![failures][failures]

If the tests pass, the new docker images for the frontend and backend are pushed to Docker Hub, and subsequently pulled down as images for the Docker container deployment managed by Kubernetes.

## Flask App

The picture below shows the structure of the cluster hosting the Flask application. Three replicas of the frontend and three replicas of the backend are deployed, and the deployments are assigned with Cluster IPs. The frontend Cluser IP naturally load-balances between the three backend pods. A load balancer deployed by Kubernetes splits traffic between the frontend containers using an NGINX reverse proxy. The database is accessed by the backend whenever a GET request is made by the frontend, triggered by a user accessing the load balancer on port 80 where NGINX listens.

The benefit of this structure is that when a change is made to either the frontend or backend code, the only changes are to the frontend and backend deployments. Even in a situation where backend or frontend pods are taken down and new ones created, the load balancer external IP remains unchanged, meaning that the live user experience will not be interrupted.

![cluster][cluster]

Accesing the load balancer on port 80 will show the following:

![browser][browser]


### Author
Basia Adamiec

[jenkins]: https://i.imgur.com/Ez2Pxsz.png

[architecture]: https://i.imgur.com/wEEHRHN.png

[pipeline]: https://i.imgur.com/Y12RGOg.png

[kanban]: https://i.imgur.com/94l3cn6.png
[burndown]: https://i.imgur.com/2XwEDaP.png

[frontendtest]: https://i.imgur.com/wz3MkW1.png
[backendtest]: https://i.imgur.com/dOb6OZe.png
[failures]: https://i.imgur.com/qULC3iT.png

[cluster]: https://i.imgur.com/X8JQLaP.png

[browser]: https://i.imgur.com/ZD396ZX.png

