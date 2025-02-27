#!/bin/bash 

# deps
sudo apt-get install -y libboost-all-dev rapidjson-dev libeigen3-dev swig
sudo apt-get install -y openssl
sudo apt-get install -y libssl-dev

# conda create -n dlab python=3.8

eval "$(conda shell.bash hook)"
conda activate dlab
echo "after calling source: $PATH"

# pip install numpy pytest pyquaternion
# pip install biopandas pybel molgrid torch
# pip install scipy joblib
# conda install -y PyYAML biopython 



current=`pwd`
echo $current

# cmake 
wget https://github.com/Kitware/CMake/releases/download/v3.26.3/cmake-3.26.3.tar.gz
tar xzf cmake-3.26.3.tar.gz
rm cmake-3.26.3.tar.gz
cd cmake-3.26.3
./bootstrap
make
make DESTDIR=$current/cmake_bin install
cd $current

cmakeP=$current/cmake_bin/usr/local/bin/cmake

# boost
wget https://boostorg.jfrog.io/artifactory/main/release/1.80.0/source/boost_1_80_0.tar.gz
tar xzf boost_1_80_0.tar.gz
rm boost_1_80_0.tar.gz
cd boost_1_80_0
./bootstrap.sh --prefix=$current/boost_1_80_0_bin
./b2 install --prefix=$current/boost_1_80_0_bin
cd $current

boost_path=$current/boost_1_80_0_bin
export LD_LIBRARY_PATH="$boost_path/lib:$LD_LIBRARY_PATH"
echo $LD_LIBRARY_PATH

boost_include=$boost_path/include
echo "boost include"
echo $boost_include


# # openbabel 
wget https://github.com/openbabel/openbabel/archive/refs/tags/openbabel-3-0-0.tar.gz
tar xzf openbabel-3-0-0.tar.gz
rm openbabel-3-0-0.tar.gz
[ -d "openbabel-openbabel-3-0-0/build"] && echo "rm existing openbabel build" && rm -rf openbabel-openbabel-3-0-0/build
mkdir -p openbabel-openbabel-3-0-0/build
cd openbabel-openbabel-3-0-0/build
$cmakeP .. -DRUN_SWIG=ON -DPYTHON_BINDINGS=ON -DBoost_INCLUDE_DIR=$boost_include
make -j8
echo "build into: "
echo $current/openbabel_bin
make DESTDIR=$current/openbabel_bin install
cd $current


export LD_LIBRARY_PATH="$current/openbabel_bin/usr/local/lib:$LD_LIBRARY_PATH"
export BABEL_LIBDIR="$current/openbabel_bin/usr/local/lib"

# libmolgrid
git clone https://github.com/gnina/libmolgrid.git
cd libmolgrid
mkdir -p build
cd build

echo "start cmake ..."
$cmakeP .. -DBoost_INCLUDE_DIR=$boost_include -DOPENBABEL3_INCLUDE_DIR=$current/openbabel_bin/usr/local/include/openbabel3 -DOPENBABEL3_LIBRARIES=$current/openbabel_bin/usr/local/lib/libopenbabel.so
make -j8
make DESTDIR=$current/libmolgrid_bin install
cd $current

