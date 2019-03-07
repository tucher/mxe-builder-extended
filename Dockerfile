FROM tucher/mxe-builder

ENV BUILD_GROUPS=2
ENV BUILD_THREADS=16


RUN cd /mxe && make MXE_TARGETS='x86_64-w64-mingw32.static.posix x86_64-w64-mingw32.shared.posix' \
                qt5 \
                --jobs=$BUILD_GROUPS JOBS=$BUILD_THREADS \
                && make clean-pkg && make clean-junk

RUN cd /mxe && make MXE_TARGETS='x86_64-w64-mingw32.static.posix  x86_64-w64-mingw32.shared.posix' \
                cryptopp \
                cpp-netlib \
                curl \
                eigen \
                libftdi1 \
                libmicrohttpd \
                libserialport \
                libusb1 \
                lua \
                luabind \
                cgal \
                --jobs=$BUILD_GROUPS JOBS=$BUILD_THREADS \
                && make clean-pkg && make clean-junk

RUN cd /mxe && make MXE_TARGETS='x86_64-w64-mingw32.static.posix  x86_64-w64-mingw32.shared.posix' \
                boost \
                --jobs=$BUILD_GROUPS JOBS=$BUILD_THREADS \
                && make clean-pkg && make clean-junk

RUN apt-get install -y nsis
