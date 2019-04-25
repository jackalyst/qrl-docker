FROM ubuntu:18.04
MAINTAINER Jack Matier <self@jackalyst.com>

ADD https://dl.google.com/go/go1.12.4.linux-amd64.tar.gz /go1.12.4.linux-amd64.tar.gz

RUN apt-get -y update && apt-get -y upgrade && apt-get -y install swig3.0 python3-dev python3-pip build-essential cmake pkg-config libssl-dev libffi-dev libhwloc-dev libboost-dev git

RUN pip3 install -U setuptools
RUN pip3 install -U qrl

RUN apt-get -y update
RUN apt-get -y install wget git
RUN tar -C /usr/local -xzf go1.12.4.linux-amd64.tar.gz
RUN mkdir /root/go

ENV PATH "$PATH:/usr/local/go/bin"
ENV GOPATH /root/go

RUN go get github.com/theQRL/walletd-rest-proxy
RUN cd $GOPATH/src/github.com/theQRL/walletd-rest-proxy && go build

CMD ["start_qrl"]
CMD ["qrl_walletd"]
CMD ["$GOPATH/src/github.com/theQRL/walletd-rest-proxy/walletd-rest-proxy","-serverIPPort","127.0.0.1:5359","-walletServiceEndpoint","127.0.0.1:19010"]