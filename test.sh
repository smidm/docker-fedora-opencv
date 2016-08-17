#!/bin/sh

echo -e "test.sh: C++ example (CMake build):\n\n"

mkdir /test/opencv_example/_build
cd /test/opencv_example/_build
cmake ..
make
./opencv_example

echo -e "\ntest.sh: ./opencv_example should create out.png"

echo -e "\n\ntest.sh: Python example:\n\n"
python -c "import cv2; print('OpenCV version: ' + cv2.__version__ + '\npython OpenCV test successful');"
