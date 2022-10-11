# Warning: This container is not finished, let alone fully tested. Use at own risk.

## docker-lsyncd
Containerised lsyncd. Created to run on macOS for use with Unraid server as client. Compiles specific versions of rsync and lsyncd from source for compatibility.

## Todo
- Further testing
- Set up .gitignore exclusions
- Separate Dockerfile into build containers

## How to:
1. To start, clone repo:

    git clone https://github.com/lnxd/docker-lsyncd.git

2. Change to directory

    cd docker-lsyncd

3. Configure options in `lsyncd.conf`

    nano lsyncd.conf

4. Start container

    docker compose up --build
    