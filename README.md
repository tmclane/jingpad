# JingPad Setup Script

In order for this script to run you will require `git` to be installed on
your JingPad.

    sudo apt update; sudo apt install git

Once git is installed you can clone the repository and then update the submodules:

    git clone https://github.com/tmclane/jingpad.git
    cd jingpad
    git submodule update --init

Then you can enter the `jingpad` directory and run the `setup_jingpad.sh`script after
 checking to ensure  it doesn't do anything you do not want it to do.
