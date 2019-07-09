docker build -t omniasetty/multi-client:latest -t omniasetty/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t omniasetty/multi-server:latest -t omniasetty/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t omniasetty/multi-worker:latest -t omniasetty/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push omniasetty/multi-client:latest
docker push omniasetty/multi-server:latest
docker push omniasetty/multi-worker:latest

docker push omniasetty/multi-client:$SHA
docker push omniasetty/multi-server:$SHA
docker push omniasetty/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=omniasetty/multi-server:$SHA
kubectl set image deployments/client-deployment client=omniasetty/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=omniasetty/multi-worker:$SHA
