# Kubernetes cluster bootstrap with ansible & kubeadm

the install-all.yml will install a kubernetes 1.17 cluster with kubeadm and flannel.


## components

- kubernetes 1.17
- flannel

## getting started

generate a new cluster join token and insert it in the inventory with

`kubeadm token generate`

or use one for tests only e.g
`sw4xjw.xfar3wciairc2n7o`

Then run the playbook:

`ansible-playbook -i inventories/<example-inventory>/ install-all.yml`

you can give your newly added Nodes the "worker" label with
`kubectl label node <nodeName> node-role.kubernetes.io/worker=worker`


<!-- for notes.txt in templates of bm helm chart: -->
<!-- 1. Get the application URL by running these commands:
{{- if contains "NodePort" .Values.service.type }}
  export NODE_PORT=$(kubectl get --namespace {{ .Release.Namespace }} -o jsonpath="{.spec.ports[0].nodePort}" services {{ template "fullname" . }})
  export NODE_IP=$(kubectl get nodes --namespace {{ .Release.Namespace }} -o jsonpath="{.items[0].status.addresses[0].address}")
  echo http://$NODE_IP:$NODE_PORT/projects
{{- else if contains "LoadBalancer" .Values.service.type }}
     NOTE: It may take a few minutes for the LoadBalancer IP to be available.
           You can watch the status of by running 'kubectl get svc -w {{ template "fullname" . }}'
  export SERVICE_IP=$(kubectl get svc --namespace {{ .Release.Namespace }} {{ template "fullname" . }} -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
  echo http://$SERVICE_IP:{{ .Values.service.externalPort }}
{{- else if contains "ClusterIP"  .Values.service.type }}
  export POD_NAME=$(kubectl get pods --namespace {{ .Release.Namespace }} -l "app={{ template "fullname" . }}" -o jsonpath="{.items[0].metadata.name}")
  echo "Visit http://127.0.0.1:8080 to use your application"
  kubectl port-forward $POD_NAME 8080:{{ .Values.service.externalPort }}
{{- end }} -->
