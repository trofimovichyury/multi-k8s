docker build -t trofimovichyury/multi-client:latest -t trofimovichyury/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t trofimovichyury/multi-server:latest -t trofimovichyury/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t trofimovichyury/multi-worker:latest -t trofimovichyury/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push trofimovichyury/multi-client:latest
docker push trofimovichyury/multi-client:$SHA
docker push trofimovichyury/multi-server:latest
docker push trofimovichyury/multi-server:$SHA
docker push trofimovichyury/multi-worker:latest
docker push trofimovichyury/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=trofimovichyury/multi-server:$SHA
kubectl set image deployments/client-deployment server=trofimovichyury/multi-client:$SHA
kubectl set image deployments/worker-deployment server=trofimovichyury/multi-worker:$SHA