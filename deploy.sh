docker build -t malexgh/multi-client:latest -t malexgh/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t malexgh/multi-server:latest -t malexgh/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t malexgh/multi-worker:latest -t malexgh/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push malexgh/multi-client:latest
docker push malexgh/multi-server:latest
docker push malexgh/multi-worker:latest
docker push malexgh/multi-client:$SHA
docker push malexgh/multi-server:$SHA
docker push malexgh/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=malexgh/multi-server:$SHA
kubectl set image deployments/client-deployment client=malexgh/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=malexgh/multi-worker:$SHA
