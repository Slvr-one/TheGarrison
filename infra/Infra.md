# about the infra:
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