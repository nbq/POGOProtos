docker-machine env default
@FOR /f "tokens=*" %%i IN ('docker-machine env default') DO @%%i
cd ..
docker build --build-arg BUILD_BRANCH=0.79.2 --build-arg BUILD_REPO=nbq/POGOProtos -t pokemongo-api . 
pause
docker images
pause
