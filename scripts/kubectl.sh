aws eks --region eu-west-1 update-kubeconfig --name project-cluster
kubectl get svc
cd kubectl/

kubectl apply -f secrets.yaml 
kubectl apply -f conf-nginx.yaml 
kubectl apply -f backend.yaml 
kubectl apply -f clusterip-backend.yaml 
kubectl apply -f frontend.yaml 
kubectl apply -f clusterip-frontend.yaml 
kubectl apply -f deploy-nginx.yaml 
kubectl apply -f lb-nginx.yaml 
