cd ..
docker build --build-arg BUILD_BRANCH=master BUILD_REPO="nbq/POGOProtos" -t pokemongo-api . 
pause
docker images
pause
