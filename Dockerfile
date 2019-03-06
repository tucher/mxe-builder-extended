FROM tucher/mxe-builder:06_03_2019

RUN cd /mxe && make  \
                download-qt5 \
                download-boost \
                download-cryptopp \
                download-cpp-netlib \
                download-curl \
                download-eigen \
                download-libftdi1 \
                download-libmicrohttpd \
                download-libserialport \
                download-libusb1 \
                download-lua \
                download-luabind \
                download-cgal \
                --jobs=8 JOBS=1
RUN echo "building thread count " `grep -c ^processor /proc/cpuinfo`

RUN cd /mxe && make MXE_TARGETS='x86_64-w64-mingw32.static.posix' \
                boost \
                --jobs=1 JOBS=`grep -c ^processor /proc/cpuinfo` \
                && make clean-pkg && make clean-junk

RUN cd /mxe && make MXE_TARGETS='x86_64-w64-mingw32.static.posix' \
                qt5 \
                --jobs=1 JOBS=`grep -c ^processor /proc/cpuinfo` \
                && make clean-pkg && make clean-junk

RUN cd /mxe && make MXE_TARGETS='x86_64-w64-mingw32.static.posix' \
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
                --jobs=1 JOBS=`grep -c ^processor /proc/cpuinfo` \
                && make clean-pkg && make clean-junk
    
RUN cd /mxe && make MXE_TARGETS='x86_64-w64-mingw32.shared.posix' \
                qt5 \
                --jobs=`grep -c ^processor /proc/cpuinfo` JOBS=1 \
                && make clean-pkg && make clean-junk
RUN cd /mxe && make MXE_TARGETS='x86_64-w64-mingw32.shared.posix' \
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
                --jobs=1 JOBS=`grep -c ^processor /proc/cpuinfo` \
                && make clean-pkg && make clean-junk

