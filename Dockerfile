FROM tucher/mxe-builder

ENV BUILD_GROUPS=4
ENV BUILD_THREADS=10


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
                libyaml \
                --jobs=$BUILD_GROUPS JOBS=$BUILD_THREADS \
                && make clean-pkg && make clean-junk

RUN apt-get install -y nsis

RUN mkdir /boost_bld && cd /boost_bld && \
    wget https://dl.bintray.com/boostorg/release/1.73.0/source/boost_1_73_0.tar.gz && \
    tar xvf boost_1_73_0.tar.gz && cd boost_1_73_0 && \ 
    echo 'using gcc : mxe : x86_64-w64-mingw32.static.posix-g++ : <rc>x86_64-w64-mingw32.static.posix-windres <archiver>x86_64-w64-mingw32.static.posix-ar <ranlib>x86_64-w64-mingw32.static.posix-ranlib ;' > 'user-config.jam' && \
    cd tools/build/ && \
    ./bootstrap.sh && cd /boost_bld/boost_1_73_0 && \
    ./tools/build/b2 -a -q -j 8 --ignore-site-config --user-config=user-config.jam abi=ms address-model=64 architecture=x86 binary-format=pe link=static target-os=windows threadapi=win32 threading=multi variant=release toolset=gcc-mxe cxxflags=-std=gnu++11 --layout=tagged --disable-icu --without-mpi --without-python  --prefix=/mxe/usr/x86_64-w64-mingw32.static.posix --exec-prefix=/mxe/usr/x86_64-w64-mingw32.static.posix/bin --libdir=/mxe/usr/x86_64-w64-mingw32.static.posix/lib --includedir=/mxe/usr/x86_64-w64-mingw32.static.posix/include -sEXPAT_INCLUDE=/mxe/usr/x86_64-w64-mingw32.static.posix/include -sEXPAT_LIBPATH=/mxe/usr/x86_64-w64-mingw32.static.posix/lib install && \
    rm -rf /boost_bld

RUN mkdir /boost_bld && cd /boost_bld && \
    wget https://dl.bintray.com/boostorg/release/1.73.0/source/boost_1_73_0.tar.gz && \
    tar xvf boost_1_73_0.tar.gz && cd boost_1_73_0 && \ 
    echo 'using gcc : mxe : x86_64-w64-mingw32.shared.posix-g++ : <rc>x86_64-w64-mingw32.shared.posix-windres <archiver>x86_64-w64-mingw32.shared.posix-ar <ranlib>x86_64-w64-mingw32.shared.posix-ranlib ;' > 'user-config.jam' && \
    cd tools/build/ && \
    ./bootstrap.sh && cd /boost_bld/boost_1_73_0 && \
    ./tools/build/b2 -a -q -j 8 --ignore-site-config --user-config=user-config.jam abi=ms address-model=64 architecture=x86 binary-format=pe link=shared target-os=windows threadapi=win32 threading=multi variant=release toolset=gcc-mxe cxxflags=-std=gnu++11 --layout=tagged --disable-icu --without-mpi --without-python  --prefix=/mxe/usr/x86_64-w64-mingw32.shared.posix --exec-prefix=/mxe/usr/x86_64-w64-mingw32.shared.posix/bin --libdir=/mxe/usr/x86_64-w64-mingw32.shared.posix/lib --includedir=/mxe/usr/x86_64-w64-mingw32.shared.posix/include -sEXPAT_INCLUDE=/mxe/usr/x86_64-w64-mingw32.shared.posix/include -sEXPAT_LIBPATH=/mxe/usr/x86_64-w64-mingw32.shared.posix/lib install && \
    rm -rf /boost_bld
