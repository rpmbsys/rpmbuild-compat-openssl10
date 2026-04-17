ARG os=8.10.20240528
FROM aursu/rpmbuild:${os}-build

USER root
RUN dnf -y install \
        perl readline-devel openssl-devel \
        ncurses-devel zlib-devel \
        time \
    && dnf clean all && rm -rf /var/cache/dnf

COPY SOURCES ${BUILD_TOPDIR}/SOURCES
COPY SPECS ${BUILD_TOPDIR}/SPECS

RUN chown -R $BUILD_USER ${BUILD_TOPDIR}/{SOURCES,SPECS}

USER $BUILD_USER
ENTRYPOINT ["/usr/bin/rpmbuild", "mysql.spec"]
CMD ["-ba"]
