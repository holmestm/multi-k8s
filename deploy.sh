docker build -t holmestm/multi-client:latest -t holmestm/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t holmestm/multi-server:latest -t holmestm/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t holmestm/multi-worker:latest -t holmestm/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push holmestm/multi-client:latest
docker push holmestm/multi-server:latest
docker push holmestm/multi-worker:latest
docker push holmestm/multi-client:$SHA
docker push holmestm/multi-server:$SHA
docker push holmestm/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/client-deployment client=holmestm/multi-client:$SHA
kubectl set image deployments/server-deployment server=holmestm/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=holmestm/multi-worker:$SHA