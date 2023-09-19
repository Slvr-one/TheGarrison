<div align="center">

# Welcome to my portfolio! 👋

## Project B∞kmaker 📖

</div>

* Hi! 
* This is my portfolio git repository where you can browse through the infrastructure of underling virtualization, demonstraiting some App deploiment and maintnence nedded, provisioned for local / cloud computing and clustering, using: Terraform, Ansible, Kubeadm & other tools.

## Content-Table

* [About the Project](#about-the-project)
* [Built With](#built-with)

* [Prerequisites](#prerequisites)
* [Getting Started](#getting-started)
* [Roadmap](#roadmap)


## about-the-project:
* demontraiting a simple app that allows creation of a horsses, investments (gamble on a horse) and saves state to a database.
* Bookmaker app for race betts and API connection on several paths, built using golang.
* actual app code separate repo [App repo][bmrepo]


## built-with:
* App
  * [Golang][go] 
  * [Gin][gin] - A web framework for Golang
  * [Kratos][kratos] - A Go framework for microservices.
  <!-- * [Gorm](https://gorm.io/) -->
  <!-- * [JWT](https://jwt.io/) -->
* Infra 
  * [Mongo][mongo-go-d] - A NoSQL database
  * [Docker][docker] - container runtime
  * [Docker Compose][docker-compose]
  * [Kubernetes][k8s]
* Observability:
  * [Prometheus][prome] - Monitoring
  * [Grafana][grafana] - Visualization for Prometheus data
  <!-- * [ELK Stack][elk] - A monitoring system that is known for its ease of use and scalability. -->
* Security
  * [Cert Manager][cert-manager] - Automate the management and issuance of TLS certificates from various issuing sources.
  * [letsencrypt][letsencrypt] - A free, automated, and open Certificate Authority.
  <!-- * [Traefik][traefik] - A modern HTTP reverse proxy and load balancer made to deploy microservices with ease. -->
  <!-- * [Keycloak][keycloak] - A modern identity and access management solution. -->
  * [external Secrets][x-secret] - an external secret operator for better handling secret.

* CI/CD:
  * [Jenkins][jenkins] - CI server & pipeline
  * [ArgoCD][argocd] - CD for k8s
  <!-- * [ArgoCD Image Updater](https://github.com/argoproj-labs/argocd-image-updater) -->
  <!-- * [ArgoCD Notifications](https://argoproj-labs.github.io/argocd-notifications/) -->
* Config
  <!-- * [Kustomize][kusto] - Customizing k8s configurations -->
  * [Helm][helm] - k8s package manager
  <!-- * [Ansible][ansible] - Configuration management tool -->
  * [Helmfile][helmf] - Helm charts Config manager

    
## prerequisites:
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

## getting-started -> 
<!-- TODO -->
To get started with this project, follow these steps:
1. Clone this repo: 
> `git clone https://github.com/Slvr-one/TheGarrison.git infra && cd infra`
2. deploy infra:
> `./scripts/init_cluster.sh`
<!-- 3. config infra:
> `./scripts/config_cluster.sh` -->
<details>
<summary>note!</summary>
[make sure to set vars in the scripts to fit yourself]
</details>

## roadmap 
<!-- TODO -->
<details>
<summary>Short-term goals</summary>

- Implement user authentication
- Add support for static file serving
- Improve error handling & logging into elk
- Organize into dirs
- Add comments
</details>

<details>
<summary>Long-term goals</summary>

- Integrate with third-party APIs
- Implement a recommendation engine
- Scale the application to handle high traffic
- add tools:
  - general:
    - cespare / reflex
  - go:
    - alpeb / go-finance
    - goreleaser / goreleaser
  - k8s:
    - nabsul / k8s-ecr-login-renew
    - aquasecurity / trivy
    - avsthiago / kopylot
    - uber-archive / makisu
</details>

## Contact:
If you have any questions or would like to learn more about my work, don't hesitate to reach out:

- 🌐 Connect with me on [![linkedin](https://img.shields.io/badge/linkedin-0A66C2?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/dvir-gross-929252224/)
- ✉️ Reach out to me at [dviross@outlook.com](mailto:dviross@outlook.com)
- 🌟 More [About Me](https://github.com/Slvr-one/Slvr-one/blob/main/README.md)


---
**[`back to top  ^`](#content-table)**

This repository is maintained by [Dvir Gross](https://github.com/Slvr-one). 

[go]: https://golang.org/
[gin]: https://github.com/gin-gonic/gin
[kratos]: github.com/go-kratos/kratos/v2

<!-- [nginx]: https://www.nginx.com/ -->

[mongo-go-d]: https://github.com/mongodb/mongo-go-driver
[docker]: https://www.docker.com/
[docker-compose]: https://docs.docker.com/compose/
[k8s]: https://kubernetes.io/
 
[cert-manager]: https://cert-manager.io/
[letsencrypt]: https://letsencrypt.org/
<!-- [x-secret]: https://external-secrets.io/v0.8.0/ -->

[prome]: https://prometheus.io/
[grafana]: https://grafana.com/
<!-- [elk]: https://www.elastic.co/what-is/elk-stack -->

<!-- [fluentd]: https://www.fluentd.org/ -->
<!-- [fluent-bit]: https://fluentbit.io/ -->


<!-- [traefik]: https://traefik.io/ -->

[jenkins]: https://www.jenkins.io/
[argocd]: https://argoproj.github.io/argo-cd/

[kusto]: https://kustomize.io/
[helm]: https://helm.sh/
[ansible]: https://www.ansible.com/
[helmf]: https://helmfile.readthedocs.io/en/latest/
