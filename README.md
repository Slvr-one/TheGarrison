<div align="center">

# Welcome to my portfolio! 👋

## [ Project B∞kmaker ] 📖

</div>

* Hello there! 
* This is my portfolio git repository where you can browse through a custom app i build from scratch in golang,
while self learning the inner working of this amaizing coding experience of a language.

## Table of Contents

* [About the Project](#about-the-project)
* [Built With](#built-with)

* [Prerequisites](#prerequisites)
* [Getting Started](#getting-started)
* [Roadmap](#roadmap)


## about-the-project
* This is a simple app that allows you to create a new horse / investment (gamble on a horse) and save it to a database.
* Bookmaker app for light gambling and API connection on several paths, built with golang.
* For more details about the app, check the [App repo][bmrepo]



## built-with
* App
  * [Golang][go]
  * [Gin][gin]
  * [Mongo][mongo-go-d]
  <!-- * [Gorm](https://gorm.io/) -->
  <!-- * [JWT](https://jwt.io/) -->
* Infra 
  * Virtualization: 
    * [Docker][docker]
    * [Docker Compose][docker-compose]
    * [Kubernetes][k8s]
  * Observability:
    * [Prometheus][prome]
    * [Grafana][grafana]
  * CI/CD:
    * [Jenkins][jenkins]
    * [ArgoCD][argocd]
  <!-- * [ArgoCD Image Updater](https://github.com/argoproj-labs/argocd-image-updater) -->
  <!-- * [ArgoCD Notifications](https://argoproj-labs.github.io/argocd-notifications/) -->
* Config
  * [Kustomize][kusto]
  * [Helm][helm]
  * [Helmfile][helmf]

    
## prerequisites
<!-- TODO -->
* A computer running Windows, macOS, or Linux
* Familiarity with basic software development concepts (e.g., version control, build tools, testing)
* Familiarity with basic operations concepts (e.g., infrastructure provisioning, cloud computing, container orchistration )
* Basic understanding of YAML syntax [replace values for your environment]
* Familiarity with the command line interface (CLI)
* Familiarity with basic Kubernetes concepts (e.g., pods, deployments, services)
* Access to the servers or machines you will be managing with Ansible
* Access to a Jenkins server (either locally or remotely)
* Access to a Docker installation on your local machine
<!-- * Familiarity with basic Jenkins concepts (e.g., pipelines, jobs, agents) -->
<!-- * Basic understanding of programming concepts (e.g., variables, functions, control flow) -->
<!-- * Access to a Kubernetes cluster (e.g., Minikube, GKE, EKS) -->
<!-- - Familiarity with golang syntax and concepts -->
<!-- - Basic understanding of object-oriented programming -->

## getting-started
<!-- TODO -->
To get started with this project, follow these steps:
1. deploy infra:
2. config infra:
3. Clone the repository: `git clone https://github.com/Slvr-one/bookmaker.git`
4. build sources into an image: `./scripts/dockerize.sh`
5. release the image to a private repo: `./scripts/release.sh`

## roadmap
<!-- TODO -->
<details>
<summary>Short-term goals</summary>

- Implement user authentication
- Add support for static file serving
- Improve error handling & logging into elk

</details>

<details>
<summary>Long-term goals</summary>

- Integrate with third-party APIs
- Implement a recommendation engine
- Scale the application to handle high traffic

</details>

## Contact
If you have any questions or would like to learn more about my work, don't hesitate to reach out:

- 🌐 Connect with me on [LinkedIn](https://www.linkedin.com/in/dvir-gross-929252224/)
- ✉️ Reach out to me at [dviross@outlook.com](mailto:dviross@outlook.com)
- 🌟 Check out my [GitHub Profile README](https://github.com/Slvr-one/Slvr-one/blob/main/README.md)


---
This repository is maintained by [Dvir Gross](https://github.com/Slvr-one). 

[go]: https://golang.org/
[gin]: https://github.com/gin-gonic/gin
[mongo-go-d]: https://github.com/mongodb/mongo-go-driver

[docker]: https://www.docker.com/
[docker-compose]: https://docs.docker.com/compose/
[k8s]: https://kubernetes.io/
[helm]: https://helm.sh/
[prome]: https://prometheus.io/
[grafana]: https://grafana.com/
[jenkins]: https://www.jenkins.io/
[argocd]: https://argoproj.github.io/argo-cd/
[kusto]: https://kustomize.io/
[helmf]: https://helmfile.readthedocs.io/en/latest/

[bmrepo]: https://github.com/Slvr-one/bookmaker