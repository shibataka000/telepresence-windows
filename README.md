# telepresence-windows

This repository is fork of [saranrajj/telepresence-windows](https://github.com/saranrajj/telepresence-windows). It enable to use [Telepresence](https://github.com/telepresenceio/telepresence) in Windows 10.

## Purpose
This repository enable to use Telepresence in following environment.

- Windows 10
- Application Development by Golang
- EKS

## Requirements
- Windows 10
- Docker Desktop

## Usage
```bash
# Pull docker image
docker pull shibataka000/telepresence

# Download packages
cd $GOPATH/src/github.com/your_github_account/your_app_repository
go mod download

# Run Telepresence
# `path_to_your_app_code.go` is path from `your_app_repository` directory.
docker run \
    --net=host \
    --ipc=host \
    --uts=host \
    --pid=host \
    --security-opt=seccomp=unconfined \
    --privileged \
    -v $HOME/.aws/:/root/.aws \
    -v $HOME/.kube:/root/.kube \
    -v $GOPATH:/go \
    --rm -it \
    shibataka000/telepresence \
    --run go run /go/src/github.com/your_github_account/your_repository/path_to_your_code.go
```

## Notes
- This repository use vpn-tcp method as Telepresence proxying method. [saranrajj/telepresence-windows](https://github.com/saranrajj/telepresence-windows) use container method but it doesn't work in Docker Desktop, because Telepresence reports an error if the docker daemon is not local in telepresence 0.102 or later.
- You should download 3rd party library at private repository which your application use, because private repository can't be accessed from container inside.
