ARG MAJOR_VERSION="${MAJOR_VERSION:-r9}"

FROM ghcr.io/charles8191/rocky-bootc:$MAJOR_VERSION

# Add Cockpit basic components (ws can run containerized) and tmux
RUN dnf -y install tmux cockpit-system cockpit-bridge cockpit-podman cockpit-files

# Install/remove packages to make an image with resembles Fedora CoreOS
COPY build.sh /tmp/build.sh
RUN chmod +x /tmp/build.sh &&\
    /tmp/build.sh && \
    dnf clean all && \
    ostree container commit

# Just gotta get this green!
RUN bootc container lint
