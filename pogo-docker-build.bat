docker-machine env default
@FOR /f "tokens=*" %%i IN ('docker-machine env default') DO @%%i
docker build --build-arg BUILD_BRANCH=0.79.2-Build --build-arg BUILD_REPO=nbq/POGOProtos -t pokemongo-api . 
pause
