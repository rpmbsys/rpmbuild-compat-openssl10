ARG os=8.10.20240528
FROM aursu/rpmbuild:${os}-build

USER root
RUN dnf -y install \
        gcc \
        coreutils perl-interpreter perl-generators sed zlib-devel \
        lksctp-tools-devel \
        perl-File-Find-Rule "perl(File::Compare)" \
        /usr/bin/rename /usr/bin/pod2man /usr/bin/cmp \
        "perl(FileHandle)" \
    && dnf clean all && rm -rf /var/cache/dnf

COPY SOURCES ${BUILD_TOPDIR}/SOURCES
COPY SPECS ${BUILD_TOPDIR}/SPECS

RUN chown -R $BUILD_USER ${BUILD_TOPDIR}/{SOURCES,SPECS}

USER $BUILD_USER
ENTRYPOINT ["/usr/bin/rpmbuild", "compat-openssl10.spec"]
CMD ["-ba"]
