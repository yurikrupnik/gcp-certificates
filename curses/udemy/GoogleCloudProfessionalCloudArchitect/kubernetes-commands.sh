#! /bin/bash

#create cluster
gcloud beta container --project "gcp-certificates-363618" clusters create "my-first-cluster" \
  --zone "europe-west1-b" --no-enable-basic-auth --cluster-version "1.22.12-gke.2300" \
  --release-channel "regular" --machine-type "e2-medium" --image-type "COS_CONTAINERD" \
  --disk-type "pd-standard" --disk-size "100" --metadata disable-legacy-endpoints=true\
  --scopes "https://www.googleapis.com/auth/devstorage.read_only","https://www.googleapis.com/auth/logging.write","https://www.googleapis.com/auth/monitoring","https://www.googleapis.com/auth/servicecontrol","https://www.googleapis.com/auth/service.management.readonly","https://www.googleapis.com/auth/trace.append" \
  --max-pods-per-node "110" --num-nodes "3" --logging=SYSTEM,WORKLOAD --monitoring=SYSTEM \
  --enable-ip-alias --network "projects/gcp-certificates-363618/global/networks/default" \
  --subnetwork "projects/gcp-certificates-363618/regions/europe-west1/subnetworks/default"\
  --no-enable-intra-node-visibility --default-max-pods-per-node "110" --no-enable-master-authorized-networks\
  --addons HorizontalPodAutoscaling,HttpLoadBalancing,GcePersistentDiskCsiDriver --enable-autoupgrade --enable-autorepair\
  --max-surge-upgrade 1 --max-unavailable-upgrade 0 --enable-shielded-nodes --node-locations "europe-west1-b"
#end create cluster

gcloud config set project my-kubernetes-project-304910
gcloud config set container/cluster my-first-cluster
gcloud container clusters get-credentials my-cluster --zone us-central1-c --project my-kubernetes-project-304910
kubectl create deployment hello-world-rest-api --image=in28min/hello-world-rest-api:0.0.1.RELEASE
kubectl get deployment
kubectl expose deployment hello-world-rest-api --type=LoadBalancer --port=8080
kubectl get services
kubectl get services --watch
curl 35.184.204.214:8080/hello-world
kubectl scale deployment hello-world-rest-api --replicas=3
gcloud container clusters resize my-cluster --node-pool default-pool --num-nodes=2 --zone=us-central1-c
kubectl autoscale deployment hello-world-rest-api --max=4 --cpu-percent=70
kubectl get hpa
kubectl create configmap hello-world-config --from-literal=RDS_DB_NAME=todos
kubectl get configmap
kubectl describe configmap hello-world-config
kubectl create secret generic hello-world-secrets-1 --from-literal=RDS_PASSWORD=dummytodos
kubectl get secret
kubectl describe secret hello-world-secrets-1
kubectl apply -f deployment.yaml
gcloud container node-pools list --zone=us-central1-c --cluster=my-cluster
kubectl get pods -o wide

#
gcloud container clusters resize my-first-cluster --node-pool default-pool --num-nodes=2 --zone=europe-west1-b
gcloud container clusters update my-first-cluster --enable-autoscaling --min-nodes=1 --max-nodes=3 --zone=europe-west1-b
#
kubectl set image deployment hello-world-rest-api hello-world-rest-api=in28min/hello-world-rest-api:0.0.2.RELEASE
kubectl get services
kubectl get replicasets
kubectl get pods
kubectl delete pod hello-world-rest-api-58dc9d7fcc-8pv7r

kubectl scale deployment hello-world-rest-api --replicas=1
kubectl get replicasets
gcloud projects list

kubectl delete service hello-world-rest-api
kubectl delete deployment hello-world-rest-api
gcloud container clusters delete my-cluster --zone us-central1-c
