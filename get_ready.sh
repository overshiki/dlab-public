#!/bin/bash
conda activate dlab
current=`pwd`
export LD_LIBRARY_PATH="$current/boost_1_65_1_bin/lib:$LD_LIBRARY_PATH"
export PATH="$current/external/psa_execs:$PATH"