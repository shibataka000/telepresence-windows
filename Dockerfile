FROM ubuntu:18.04

RUN apt-get update && apt-get install -y curl

# Install kubectl v1.16.9
RUN curl -sL -o /usr/local/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/v1.16.9/bin/linux/amd64/kubectl
RUN chmod +x /usr/local/bin/kubectl

# Install telepresence
RUN curl -s https://packagecloud.io/install/repositories/datawireio/telepresence/script.deb.sh | bash
RUN apt-get update && apt-get install -y \
  iptables \
  sudo \
  telepresence

# Install awscli v1.18.53
RUN apt-get update && apt-get install -y python3-pip
RUN pip3 install awscli==1.18.53

# Install golang v1.12.17
RUN curl -s -o /tmp/go.tar.gz https://storage.googleapis.com/golang/go1.12.17.linux-amd64.tar.gz
RUN tar zxf /tmp/go.tar.gz
RUN mv go /usr/local/
ENV PATH "$PATH:/usr/local/go/bin"
ENV GOPATH /go

WORKDIR /go

ENTRYPOINT ["telepresence"]
CMD ["--run-shell"]
