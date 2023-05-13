#!/bin/bash
echo "before calling source: $PATH"
eval "$(conda shell.bash hook)"
conda activate dlab
echo "after calling source: $PATH"