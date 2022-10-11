# Warning: This container is not finished, let alone fully tested. Use at own risk.

## docker-lsyncd
Containerised lsyncd. Created to run on macOS for use with Unraid server as client. Compiles specific versions of rsync and lsyncd from source for compatibility.

## Purpose
There are many more polished containers out there, but none of them worked out of the box for my setup. I need to have a specific version of the rsync binary on my Unraid server for compatibility reasons.

I use this container to sync files between my Macbook (arm) and a VM on my server (x86_64) over Wireguard so I can code from my mac and do x64 staging over ssh. SMB was an extra level to troubleshoot when things didn't work as expected, and my mac doesn't like sshfs.

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
    