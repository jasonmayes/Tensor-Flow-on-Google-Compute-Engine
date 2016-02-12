# Tensor-Flow-on-Google-Compute-Engine

**A simple script to set up GCE environment in Google Cloud so it is ready to run TensorFlow - an Open Source Software Library for Machine Intelligence.**


## Requirements

You can probably get away with a lower spec machine (it may run slower - when compiling all cores were used to 100%!), but one thing you should pay attention to is RAM. Even with the 3.6 GB we have here, we still had to use SWAP when building at certain points. Given that hard drive disks on GCE are not physically attached to the machine (they are network attached I believe) this is not something you want to do often. 3.6GB seemed to be the sweet spot where it spent most of its time in RAM except a 1 or 2 times where it used almost the full 8GB of RAM + Swap. 

Anyhow, here is my machine spec on GCE:

* n1-highcpu-4 instance with 3.6GB RAM
* Running vanilla Ubuntu Trusty 14.04 LTS.
* 20GB persistent disk (we shall be using 4GB of this for our swap partition, and the rest you will need to store all your images and such). You could probably get away with less, but this gives us some flexablity. As an FYI after I had everything installed with OS I had used just under 14GB of space.


## Usage / Quick Start

* Save the script to your home directory.
* chmod +x setupTensorFlowGCE.sh
* Run: ./setupTensorFlowGCE.sh and follow any instructions.


## Notes
This script has been tried and tested within the Google Compute Engine environment. I have good faith it would work on other cloud services too assuming the base image of the OS was the same and was a 64bit CPU.

Once you have run this script, you can run the following commands to classify your own image using the default trained model provided by TensorFlow:

```shell
cd /home/yourUsername/tensorflow/tensorflow
```

```shell
bazel-bin/tensorflow/models/image/imagenet/classify_image --image_file=foo.jpg
```

Also worthy of note is that in this script we fetch and compile Python from source. Depending on what repos you wish to add to your server you may be able to simplify this step by using this instead:

```shell
sudo add-apt-repository ppa:fkrull/deadsnakes
sudo apt-get update
sudo apt-get install python2.7
```

## What gets installed?

Not a lot, but it's the setup and the dependencies for the below that take time to find if doing this by yourself! 
Life is always simpler when you have the answer infront of you...

* Java 8
* [Bazel](https://github.com/bazelbuild/bazel) for building
* Python and associated deps.
* [TensorFlow](https://github.com/tensorflow/tensorflow)
* Git
* Unzip
* Dependiences for all of the above. See script for exact details.


## What gets changed?

* A swap partition is created on your physical disk
* Swappiness value for the OS is changed so that it prefers to use RAM. It will only use swap when RAM is full.
* $PATH has $HOME/bin added to it.
 

## Questions / Comments / Disclaimer

This has been tried and tested with the current version of [TensorFlow](https://github.com/tensorflow/tensorflow) as at 12th Feb 2016.

Also I would just like to say I am not by any means an expert on Tensor Flow, or machine learning, I am learning as I go along and sharing what I find in the hope it will help others out who are also just getting started and want to get playing quickly in the cloud.

If you found this useful, you may enjoy my other ramblings and discoveries. Feel free to [check out my website to connect with me on social channels](http://www.jasonmayes.com).
