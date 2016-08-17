Build and Test Docker Container
===============================

    $ sudo docker build -t fedora-opencv ./docker
    $ sudo docker run -t -i -v $PWD:/test fedora-opencv /bin/bash
    $ /test/test.sh  # test C++ and Python OpenCV API

Tested Versions
---------------

|Fedora | OpenCV
|------ | ------
|24     | 3.1.0
|24     | 2.4.13


