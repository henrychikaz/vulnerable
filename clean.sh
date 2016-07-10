docker ps -a -q -f ancestor=karthikvkrishnan/vulnerableapp | xargs docker kill
docker ps -a -q -f ancestor=karthikvkrishnan/vulnerableapp | xargs docker rm
docker rmi karthikvkrishnan/vulnerableapp
