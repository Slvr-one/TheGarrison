#!/bin/bash
set -eu

# #expose argocd server service on 6003
kubectl -n argocd port-forward svc/argo-cd-argocd-server 6003:80


# expose prometheus & grafana main ui services 
`kubectl -n prometheus port-forward svc/kube-prometheus-stack-grafana 6001:80`

`kubectl -n prometheus port-forward svc/kube-prometheus-stack-prometheus 6002:9090`

`kubectl -n argocd port-forward svc/argo-cd-argocd-server 6003:443`

# while true; do kubectl port-forward — address X.X.X.X deployment/kibana 5601:5601 -n logging; done


#patch argocd server to load balancer
kubectl -n argocd patch svc argo-cd-argocd-server -p '{"spec": {"ports": [{"port": 443,"targetPort": 443,"name": "https"},{"port": 80,"targetPort": 80,"name": "http"}],"type": "LoadBalancer"}}'

#replace in place the argocd server svc      
kubectl -n argocd get svc argo-cd-argocd-server -o yaml | kubectl replace -f -
