FROM registry.redhat.io/rhel8/postgresql-12

USER 0

COPY contrib/ /opt/app-root/src

RUN /usr/libexec/fix-permissions --read-only /opt/app-root/src

USER 26
