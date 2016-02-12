# Tensor-Flow-on-Google-Compute-Engine

**A simple script to set up GCE environment in Google Cloud so it is ready to run TensorFlow - an Open Source Software Library for Machine Intelligence.**


## Requirements

You can probably get away with a lower spec machine (it may run slower - when compiling all cores were used to 100%!), but one thing you should pay attention to is RAM. Even with the 3.6 GB we have here, we still had to use SWAP when building at certain points. Given that hard drive disks on GCE are not physically attached to the machine (they are network attached I believe) this is not something you want to do often. 3.6GB seemed to be the sweet spot where it spent most of its time in RAM except a 1 or 2 times where it used almost the full 8GB of RAM + Swap. 

Anyhow, here is my machine spec on GCE which is a standard instance config:

* n1-highcpu-4 instance with 3.6GB RAM.
* Running vanilla Ubuntu Trusty 14.04 LTS.
* 20GB persistent disk (we shall be using 4GB of this for our swap partition, and the rest you will need to store all your images and such). You could probably get away with less, but this gives us some flexablity. As an FYI after I had everything installed with OS I had used just under 14GB of space.


## Usage

* Save the script to your home directory.
* chmod +x setupTensorFlowGCE.sh
* Run: ./setupTensorFlowGCE.sh


## Notes
This script has been tried and tested within the Google Compute Engine environment. I have good faith it would work on other cloud services too assuming the base image of the OS was the same and was a 64bit CPU.


## What gets installed?

Not a lot, but its the setup and the deps that take time to find if doing this by yourself! Life is always simpler when you have the answer infront of you...

* Java 8
* [Bazel](https://github.com/bazelbuild/bazel) for building
* Python and associated deps
* [TensorFlow](https://github.com/tensorflow/tensorflow)


## What gets changed?

* We create a swap partition on your physical disk
* We change the swappiness value for the OS so that it prefers to use RAM. It will only use swap when RAM is full.
 

## Questions / Comments?

This has been tried and tested with the current version of [TensorFlow](https://github.com/tensorflow/tensorflow) as at 12th Feb 2016. 
