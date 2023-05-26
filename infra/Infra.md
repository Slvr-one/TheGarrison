# about the infra:

* infra/a = bootstraped kubernetes env by aws on 6 ec2's, terraform & ansible (TODO).

* infra/b = aws managed kubernetes, terraform & aws eks.

* infra/c digital ocean managed infrastructute on droplets.
"""
apps {
    bookmaker (custom app - golang),
    cert-manager (manages ca certs for cluster - ingress), 
    efk-logging[
        elastic search (database),
        fluent-d / bit (),
        kibana ( logging & graphs ui)
    ],
    kube-monitoring (prometheus with grafana ui and more),
    nginx-ingress (kubernetes nginx ingress implementation),
    secret-manager (external secret manager)
}
"""