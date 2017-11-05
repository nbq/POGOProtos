#!/bin/bash

rm -rf /src/pogoprotos/
git clone https://github.com/nbq/POGOProtos /src/pogoprotos/

cd /src/pogoprotos/
python compile.py python
tar -zcf out.tar.gz out
cp out.tar.gz /tmp/
cd /src