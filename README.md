# Tensor-Flow-on-Google-Compute-Engine

**A simple script to set up GCE environment in Google Cloud so it is ready to run TensorFlow - an Open Source Software Library for Machine Intelligence.**

![alt text](https://cloud.githubusercontent.com/assets/4972997/13024300/8889655a-d1a7-11e5-8bb5-5bb4e72bf21e.png "Recognizing Pandas on GCE!")

## Requirements

You can probably get away with a lower spec machine (it may run slower - when compiling all cores were used to 100%!), but one thing you should pay attention to is RAM. Even with the 3.6 GB we have here, we still had to use SWAP when building at certain points. Given that hard drive disks on GCE are not physically attached to the machine (they are network attached I believe) this is not something you want to do often. 3.6GB seemed to be the sweet spot where it spent most of its time in RAM except a 1 or 2 times where it used almost the full 8GB of RAM + Swap. 

Anyhow, here is my machine spec on GCE:

* n1-highcpu-4 instance with 3.6GB RAM
* Running vanilla Ubuntu Trusty 14.04 LTS.
* 20GB persistent disk (we shall be using 4GB of this for our swap partition, and the rest you will need to store all your images and such). You could probably get away with less, but this gives us some flexibility. As an FYI after I had everything installed with OS I had used just under 14GB of space.


## Usage / Quick Start

A heads up of what your 5 minutes of fun will look like (sped up 400%):
![tfinstall](https://cloud.githubusercontent.com/assets/4972997/13024353/24cfb9d2-d1a8-11e5-9e61-3f5e81e8fe66.gif)

Lets go...

1. Save the script to your home directory.
2. ```chmod +x setupTensorFlowGCE.sh ```
3. Run: ```./setupTensorFlowGCE.sh``` and follow any instructions that appear (basically say yes to everything and accept Java licence). This will take about 5 mins to install everything if you are watching the screen :-) Once it has finished run ```source ~/.bashrc``` to ensure your terminal can find bazel. Alternatively you can just log out and in again.
4. Now the environment is setup we can compile TensorFlow. Ensure you are in correct directory: ```cd ~/tensorflow/tensorflow``` and then run: ```bazel build -c opt //tensorflow/tools/pip_package:build_pip_package```. This will take some time to compile. Grab a coffee. No really, we are looking at about 35 minutes here...
5. TensorFlow is now ready to be used! Woohoo! Run the included example to test: ```bazel run tensorflow/models/image/imagenet:classify_image```


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


## Performance

One must remember here that this is raw CPU based data. If you have GPU support in the cloud performance will be way better, but at present GCE only has CPU based instances.

I have tested peformance via a real world scenario of retraining one of the Tensor Flow examples of recognizing a custom object on a vareity of instance sizes. When you retrain the top layers of the model the system creates "bottlenecks" (a term referring to the layer just before the final output layer that actually does the classification) for all the input images. These take time to create and even on multicore systems pushes all cores close to 100%. So lets have some fun...

![cpuusage](https://cloud.githubusercontent.com/assets/4972997/13094360/0b3db572-d4bf-11e5-8555-acc9bf143987.gif)

**Input data:** 1920x1080 pixel resolution images (consider you will typically have 2000 - 3000 images as input data, maybe more, and each image has a coresponding "bottleneck" file needed to be generated).

### Results

I got the following results on different instance sizes:

* **n1-highcpu-4** generated 4 bottlenecks per minute on average (4.1 hours per 1000 images).
* **n1-highcpu-16** generated 15 bottlenecks per minute on average. (1.1 hours per 1000 images).
* **n1-highcpu-24** generated 19 bottlenecks per minute on average. (53 mins per 1000 images). It should be noted that with a default Google account 24 CPUs is the maximum you can have in any one region without requesting an upgrade.

As you can see, even with 24 virtual CPUs at work, it still takes a long time. If time is key, you are going to need to find a solution with the right GPU support to compile Tensor Flow with GPU support enabled. The only scalble one I know of right now at time of writing would be Amazon's offering which supports GPU instances. If anyone wants to run this over there, please let me know the results to post.

## What gets installed?

Not a lot, but it's the setup and the dependencies for the below that take time to find if doing this by yourself! 
Life is always simpler when you have the answer infront of you...

* Java 8
* [Bazel](https://github.com/bazelbuild/bazel) for building
* Python and associated deps.
* [TensorFlow](https://github.com/tensorflow/tensorflow)
* Git
* Unzip
* Dependencies for all of the above. See script for exact details.


## What gets changed?

* A swap partition is created on your physical disk
* Swappiness value for the OS is changed so that it prefers to use RAM. It will only use swap when RAM is full.
* $PATH has $HOME/bin added to it.
 

## Questions / Comments / Disclaimer

This has been tried and tested with the current version of [TensorFlow](https://github.com/tensorflow/tensorflow) as at 12th Feb 2016.

Also I would just like to say I am not by any means an expert on Tensor Flow, or machine learning, I am learning as I go along and sharing what I find in the hope it will help others out who are also just getting started and want to get playing quickly in the cloud.

If you found this useful, you may enjoy my other ramblings and discoveries. Feel free to [check out my website to connect with me on social channels](http://www.jasonmayes.com).
