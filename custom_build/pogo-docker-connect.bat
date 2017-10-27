docker-machine env default
@FOR /f "tokens=*" %i IN ('docker-machine env default') DO @%i
cd ..
docker run --name=pokemongo-api-bash --rm -i -t -e TZ=Americas/New_York -v "D:/pgofiles/tmp/":/tmp/ --entrypoint /bin/bash pokemongo-api
pause