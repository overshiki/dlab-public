#!/bin/bash
time python data_prep_pipeline.py -c example_input_files/data_prep_config.yaml
time python dlab_re_vs_pipeline.py -c example_input_files/dlab_config.yaml