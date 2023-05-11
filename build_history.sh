#!/bin/bash 

# deps
sudo apt-get install -y libboost-all-dev rapidjson-dev libeigen3-dev swig

conda create -n dlab python=3.8

conda activate dlab
pip install numpy pytest pyquaternion
pip install biopandas pybel molgrid torch
pip install scipy joblib
conda install -y PyYAML biopython 


# openbabel 
cd openbabel_master/build/
cmake .. -DRUN_SWIG=ON -DPYTHON_BINDINGS=ON
make -j8
make DESTDIR=/shared/home/le/build/dlab/openbabel_bin install
export LD_LIBRARY_PATH="/shared/home/le/build/dlab/openbabel_bin/usr/local/lib:$LD_LIBRARY_PATH"
export PYTHONPATH="/shared/home/le/build/dlab/openbabel_bin/usr/local/lib/python3.8/site-packages/:$PYTHONPATH"

# boost
cd boost_1_82_0
./bootstrap.sh --prefix=/shared/home/le/build/dlab/boost_1_82_0_bin
./b2 install --prefix=/shared/home/le/build/dlab/boost_1_82_0_bin

# cmake 
wget https://github.com/Kitware/CMake/releases/download/v3.26.3/cmake-3.26.3.tar.gz
tar xzf cmake-3.26.3.tar.gz
rm cmake-3.26.3.tar.gz
cd cmake-3.26.3
# sudo apt-get install openssl
# sudo apt-get install libssl-dev
./bootstrap
make
make DESTDIR=/shared/home/le/build/dlab/cmake_bin install

# libmolgrid
cd libmolgrid/build
/shared/home/le/build/dlab/cmake_bin/usr/local/bin/cmake .. -DBoost_INCLUDE_DIR=/shared/home/le/build/dlab/boost_1_70_0_bin/include -DOPENBABEL3_INCLUDE_DIR=/shared/home/le/build/dlab/openbabel_bin/usr/local/include/openbabel3 -DOPENBABEL3_LIBRARIES=/shared/home/le/build/dlab/openbabel_bin/usr/local/lib/libopenbabel.so
make -j8
make DESTDIR=/shared/home/le/build/dlab/libmolgrid_bin install


export PATH="/shared/home/le/build/dlab/external/psa_execs:$PATH"