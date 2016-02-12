#!/bin/bash
#
# This script will hopefully save you a lot of time setting up GCE 
# (Google Compute Engine) to be ready to run TensorFlow.
#
# Tested using the following environment:
# - n1-highcpu-4 instance with 3.6GB RAM.
# - Running vanilla Ubuntu Trusty 14.04 LTS.
# - 20GB persistent disk.
#
# @author Jason Mayes
#
# Excessive commenting has been included below for clarity :-)
# Save this script to /home/yourUserName, chmod +x setupTensorFlowGCE.sh, + run!
#
