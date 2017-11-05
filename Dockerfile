# To build a docker container for the "master" branch (this is the default) execute:
#
# docker build --build-arg BUILD_BRANCH=master .
# (or)
# docker build .
#
# To build a docker container for the "dev" branch execute:
# 
# docker build --build-arg BUILD_BRANCH=dev .
# 
# You can also build from different fork and specify a particular commit as the branch
# 
# docker build --build-arg BUILD_REPO=YourFork/PokemonGo-Bot --build-arg BUILD_BRANCH=6a4580f .

FROM alpine

ARG BUILD_REPO=nbq/POGOProtos
ARG BUILD_BRANCH=master
ARG BUILD_REPO2=MerlionRock/pgoapi

LABEL build_repo=$BUILD_REPO build_branch=$BUILD_BRANCH

WORKDIR /usr/src/app
VOLUME ["/usr/src/app/configs", "/usr/src/app/web"]

RUN apk -U --no-cache add python py-pip tzdata ca-certificates wget bash mc git libstdc++ \
    && rm -rf /var/cache/apk/* \
    && find / -name '*.pyc' -o -name '*.pyo' | xargs -rn1 rm -f

# For wget - not used now but left for future needs
RUN update-ca-certificates

ADD https://raw.githubusercontent.com/$BUILD_REPO/$BUILD_BRANCH/requirements.txt .

# Install Protoc
################
RUN set -ex && apk --no-cache add --virtual .pb-build make cmake autoconf automake curl tar libtool g++ \
	&& mkdir -p /tmp/protobufs \
	&& cd /tmp/protobufs \
	&& curl -o protobufs.tar.gz -L https://github.com/google/protobuf/releases/download/v3.4.0/protobuf-cpp-3.4.0.tar.gz \
	&& mkdir -p protobuf \
	&& tar -zxvf protobufs.tar.gz -C /tmp/protobufs/protobuf --strip-components=1 \
	&& cd protobuf \
	&& ./autogen.sh \
	&& ./configure --prefix=/usr \
	&& make \
	&& make install \
        && cd \
	&& rm -rf /tmp/protobufs/ \
        && rm -rf /tmp/protobufs.tar.gz \
	&& apk del .pb-build \
	&& rm -rf /var/cache/apk/* \
	&& mkdir /defs

# Setup directories for the volumes that should be used
WORKDIR /defs

RUN git clone -b $BUILD_BRANCH https://github.com/$BUILD_REPO /src/pogoprotos/
RUN git clone https://github.com/$BUILD_REPO2 /src/pgoapi/
RUN cp /src/pogoprotos/run.sh /src/run.sh
RUN chmod +x /src/run.sh

CMD ["/bin/bash"]
