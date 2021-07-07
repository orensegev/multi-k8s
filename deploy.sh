docker build -t orensegev/multi-client:latest -t orensegev/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t orensegev/multi-server:latest -t orensegev/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t orensegev/multi-worker:latest -t orensegev/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push orensegev/multi-client:latest
docker push orensegev/multi-server:latest
docker push orensegev/multi-worker:latest

docker push orensegev/multi-client:$SHA
docker push orensegev/multi-server:$SHA
docker push orensegev/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=orensegev/multi-server:$SHA
kubectl set image deployments/client-deployment server=orensegev/multi-client:$SHA
kubectl set image deployments/worker-deployment server=orensegev/multi-worker:$SHA