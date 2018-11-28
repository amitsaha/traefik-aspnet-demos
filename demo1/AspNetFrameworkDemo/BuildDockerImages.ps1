$GIT_HASH=git rev-parse -q HEAD
docker build -t "amitsaha/aspnetframework-demo-site1:$GIT_HASH" -f Dockerfile.site1 .
docker build -t "amitsaha/aspnetframework-demo-site2:$GIT_HASH" -f Dockerfile.site2 .