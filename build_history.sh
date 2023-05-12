#!/bin/bash 

# deps
sudo apt-get install -y rapidjson-dev libeigen3-dev swig libssl-dev
# libboost-all-dev 


# conda create -n dlab python=3.8
# conda activate dlab
# pip install numpy pytest pyquaternion
# pip install biopandas pybel molgrid torch
# pip install scipy joblib
# conda install -y PyYAML biopython 

# cmake 
# wget https://github.com/Kitware/CMake/releases/download/v3.26.3/cmake-3.26.3.tar.gz
# tar xzf cmake-3.26.3.tar.gz
# rm cmake-3.26.3.tar.gz
cd /shared/home/le/build/dlab/cmake-3.26.3
./bootstrap
make
make DESTDIR=/shared/home/le/build/dlab/cmake_bin install

# # boost
# wget https://boostorg.jfrog.io/artifactory/main/release/1.65.1/source/boost_1_65_1.tar.gz
# tar xzf boost_1_65_1.tar.gz
# mv boost_1_65_1.tar.gz /mnt/storage5tnfs/le/deps/pkgs/
# cd /shared/home/le/build/dlab/boost_1_65_1
# ./bootstrap.sh --prefix=/shared/home/le/build/dlab/boost_1_65_1_bin
# ./b2 install --prefix=/shared/home/le/build/dlab/boost_1_65_1_bin
export LD_LIBRARY_PATH="/shared/home/le/build/dlab/boost_1_65_1_bin/lib:$LD_LIBRARY_PATH"


# # openbabel 
# # git clone https://github.com/openbabel/openbabel.git 
# # wget https://github.com/openbabel/openbabel/archive/refs/tags/openbabel-3-0-0.tar.gz
# # tar xzf openbabel-3-0-0.tar.gz
# # mv openbabel-3-0-0.tar.gz /mnt/storage5tnfs/le/deps/pkgs/
# # mkdir -p openbabel-openbabel-3-0-0/build
# cd /shared/home/le/build/dlab/openbabel-openbabel-3-0-0/build
# /shared/home/le/build/dlab/cmake_bin/usr/local/bin/cmake .. -DRUN_SWIG=ON -DPYTHON_BINDINGS=ON -DBoost_INCLUDE_DIR=shared/home/le/build/dlab/boost_1_65_1_bin/include
# make -j8
# make DESTDIR=/shared/home/le/build/dlab/openbabel_bin install
# export LD_LIBRARY_PATH="/shared/home/le/build/dlab/openbabel_bin/usr/local/lib:$LD_LIBRARY_PATH"
# export PYTHONPATH="/shared/home/le/build/dlab/openbabel_bin/usr/local/lib/python3.8/site-packages/:$PYTHONPATH"
# export BABEL_LIBDIR="/shared/home/le/build/dlab/openbabel_bin/usr/local/lib"

# libmolgrid
# git clone https://github.com/gnina/libmolgrid.git
cd libmolgrid/build
/shared/home/le/build/dlab/cmake_bin/usr/local/bin/cmake .. -DBoost_INCLUDE_DIR=/shared/home/le/build/dlab/boost_1_65_1_bin/include -DOPENBABEL3_INCLUDE_DIR=/shared/home/le/build/dlab/openbabel_bin/usr/local/include/openbabel3 -DOPENBABEL3_LIBRARIES=/shared/home/le/build/dlab/openbabel_bin/usr/local/lib/libopenbabel.so
make -j8
make DESTDIR=/shared/home/le/build/dlab/libmolgrid_bin install


