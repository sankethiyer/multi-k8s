docker build -t sankethiyer/multi-client:latest -t sankethiyer/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t sankethiyer/multi-server:latest -t sankethiyer/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t sankethiyer/multi-worker:latest -t sankethiyer/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push sankethiyer/multi-client:latest
docker push sankethiyer/multi-server:latest
docker push sankethiyer/multi-worker:latest

docker push sankethiyer/multi-client:$SHA
docker push sankethiyer/multi-server:$SHA
docker push sankethiyer/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment server=sankethiyer/multi-client:$SHA
kubectl set image deployments/server-deployment server=sankethiyer/multi-server:$SHA
kubectl set image deployments/worker-deployment server=sankethiyer/multi-worker:$SHA