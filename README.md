# Go development container

This container can be used for Go development. Based on the golang:alpine
container, it adds the following improvements:

- Does not clobber your file permissions when doing dev with your local
  directory mounted in as a volume
- Includes git, glide, and make

## Usage

The work directory must be set to the place where the working volume will be
mounted. The entrypoint script automatically creates a user inside the
container to match the work directory's ownership; the container then runs as
that user. Example:

```
docker run \
    -v `pwd`:/go/src/src.paxautoma.com/paxautoma/myproject \
    -w /go/src/src.paxautoma.com/paxautoma/myproject \
    paxautoma/golang-dev:latest
```

Another approach is to create a Docker image that is based on this one. In that
image, you must set `WORKDIR` to wherever your work directory volume will be
mounted.

```dockerfile
FROM pa-dev:latest

# ... other other customization here

WORKDIR /go/src/src.paxautoma.com/paxautoma/myproject
```

Then, run the container like this:

```
docker run \
    -v `pwd`:/go/src/src.paxautoma.com/paxautoma/myproject \
    <image-name>
```
