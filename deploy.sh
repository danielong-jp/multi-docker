# build images 
docker build -t crimsonknightd/multi-client:latest -t crimsonknightd/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t crimsonknightd/multi-server:latest -t crimsonknightd/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t crimsonknightd/multi-worker:latest -t crimsonknightd/multi-worker:$SHA -f ./worker/Dockerfile ./worker

# push latest docker images
docker push crimsonknightd/multi-client:latest
docker push crimsonknightd/multi-server:latest
docker push crimsonknightd/multi-worker:latest

# push sha docker images
docker push crimsonknightd/multi-client:$SHA
docker push crimsonknightd/multi-server:$SHA
docker push crimsonknightd/multi-worker:$SHA

# apply kubernetes
kubectl apply -f ./k8s
kubectl set image deployments/server-deployment server=crimsonknightd/multi-server:$SHA
kubectl set image deployments/client-deployment client=crimsonknightd/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=crimsonknightd/multi-worker:$SHA