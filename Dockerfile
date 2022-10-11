FROM debian:bullseye-slim

# Install default apps
RUN export DEBIAN_FRONTEND=noninteractive; \
    apt-get update; \
    apt-get upgrade -y; \
    apt-get install -y apt-utils; \
    apt-get install -y curl sudo; \
# Clean up apt
    apt-get clean all; \
# Set timezone
    ln -fs /usr/share/zoneinfo/Australia/Melbourne /etc/localtime; \
    apt-get install -y tzdata; \
    dpkg-reconfigure --frontend noninteractive tzdata; \
# Prevent error messages when running sudo
    echo "Set disable_coredump false" >> /etc/sudo.conf; \
# Create user account
    useradd docker; \
    groupadd -g 98 docker; \
    useradd --uid 99 --gid 98 docker; \
    echo 'docker:docker' | chpasswd; \
    usermod -aG sudo docker; \
    mkdir -p /home/docker;

# Install specific apps
RUN export DEBIAN_FRONTEND=noninteractive; \
    apt-get update; \
    apt-get install -y git tar build-essential lua5.4 liblua5.4-0 liblua5.4-dev cmake;
#curl -L "https://github.com/lsyncd/lsyncd/archive/refs/tags/v2.3.0.tar.gz" -o /home/docker/lsync.tar.gz; \
#mkdir -p /home/docker/lsync; \
#tar -xf /home/docker/lsync.tar.gz -C /home/docker/lsync --strip-components=1; \
RUN git clone https://github.com/lsyncd/lsyncd /home/docker/lsync/; \
    cd /home/docker/lsync/; \
    cmake .; \
    rm -rf /home/docker/lsync/tests; \
    make; \
    make install; \
    cd ..; \
    rm -rf /home/docker/lsync /home/docker/lsync.tar.gz; \
# Clean up apt
    apt-get clean all;

RUN export DEBIAN_FRONTEND=noninteractive; \
    apt-get update; \
    curl -O https://download.samba.org/pub/rsync/src/rsync-3.2.6.tar.gz; \
    tar -xzvf rsync-3.2.6.tar.gz; \
    rm rsync-3.2.6.tar.gz; \
    cd rsync-3.2.6; \
    apt-get install -y build-essential; \
    apt-get install -y libssl-dev; \
    apt-get install -y libxxhash-dev; \
    apt-get install -y libzstd-dev; \
    apt-get install -y liblz4-dev; \
    ./configure --prefix /usr/local; \
    ./configure --prefix /usr/local  --disable-zstd; \
    make; \
    make install; \
    mv /usr/bin/rsync /usr/bin/rsync.orig; \
    ln -s /usr/local/bin/rsync /usr/bin/rsync; \
    apt-get clean all;

RUN 
# Copy latest scripts
COPY start.sh lsyncd.conf exclude /home/docker/ 
RUN chmod +x /home/docker/start.sh;

# Define working directory.
WORKDIR /home/docker/

# Define default command.
CMD ["./start.sh"]