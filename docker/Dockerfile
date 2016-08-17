FROM fedora:24
MAINTAINER Matěj Šmíd <smidm@cmp.felk.cvut.cz>

ARG OPENCV_VERISON="3.1.0"
ENV NUM_CORES 4

RUN dnf install -y \
    http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
    http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm    
    
RUN dnf upgrade -y

RUN dnf install -y \
    boost-devel \
    cmake \ 
    curl \
    ffmpeg \
    ffmpeg-devel \
    gcc \
    gcc-c++ \
    less \ 
    libjpeg-devel \
    libpng12-devel \
    make \
    numpy \
    patch \
    python \ 
    python-devel \
    python-pip \
    redhat-rpm-config \
    scipy \
    sudo \
    tar \
    tbb-devel

# download, patch, build, install and setup opencv

RUN curl -sL https://github.com/Itseez/opencv/archive/$OPENCV_VERISON.tar.gz | tar xvz -C /tmp

WORKDIR /tmp/opencv-$OPENCV_VERISON

# gcc6 patch, not included in OpenCV 3.1.0 yet

RUN curl -sL https://patch-diff.githubusercontent.com/raw/opencv/opencv/pull/6541.patch | patch -p1
    
WORKDIR /tmp/opencv-$OPENCV_VERISON/_build

RUN cmake -DBUILD_SHARED_LIBS=OFF -DBUILD_TESTS=OFF -DBUILD_PERF_TESTS=OFF -DCMAKE_BUILD_TYPE=Release \
          -DBUILD_OPENCV_JAVA=OFF -D WITH_TBB=ON -D WITH_OPENCL=OFF -D WITH_CUDA=OFF \
          -D BUILD_opencv_gpu=OFF -D BUILD_opencv_gpuarithm=OFF -D BUILD_opencv_gpubgsegm=OFF \
          -D BUILD_opencv_gpucodec=OFF -D BUILD_opencv_gpufeatures2d=OFF \
          -D BUILD_opencv_gpufilters=OFF -D BUILD_opencv_gpuimgproc=OFF -D BUILD_opencv_gpulegacy=OFF \
          -D BUILD_opencv_gpuoptflow=OFF -D BUILD_opencv_gpustereo=OFF -D BUILD_opencv_gpuwarping=OFF \
          -D CMAKE_INSTALL_PREFIX=/usr/local .. && \
    make -j ${NUM_CORES} && \
    make install
    
RUN sh -c 'echo "/usr/local/lib" > /etc/ld.so.conf.d/opencv.conf' && \
    ldconfig && \
    echo "PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:$PKG_CONFIG_PATH" > /etc/profile.d/opencv.sh && \
    echo "export PKG_CONFIG_PATH" >> /etc/profile.d/opencv.sh && \
    echo "PYTHONPATH=/usr/local/lib/python2.7/site-packages/:$PYTHONPATH" >> /etc/profile.d/opencv.sh && \
    echo "export PYTHONPATH" >> /etc/profile.d/opencv.sh

# RUN echo $PKG_CONFIG_PATH && \
#    pkg-config --cflags opencv

