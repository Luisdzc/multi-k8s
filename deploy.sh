docker build -t lzarate96/multi-client:latest -t lzarate96/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t lzarate96/multi-server:latest -t lzarate96/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t lzarate96/multi-worker:latest -t lzarate96/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push lzarate96/multi-client:latest
docker push lzarate96/multi-server:latest
docker push lzarate96/multi-worker:latest

docker push lzarate96/multi-client:$SHA
docker push lzarate96/multi-server:$SHA
docker push lzarate96/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=lzarate96/multi-server:$SHA
kubectl set image deployments/client-deployment client=lzarate96/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=lzarate96/multi-worker:$SHA
