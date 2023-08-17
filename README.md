# mint-up

This script is designed to quickly install all the necessary software on Linux Mint (`install.sh`). 

The kit also includes a configurator that configures the necessary program settings (`config.sh`). 

The script allows you to download packages and install them offline. Thus, you can make an installation flash drive that installs and configures Linux Mint and all the necessary software even without an Internet connection.

The following package sources supported:
- The package name in the `apt` repository. The package and all required dependencies will be downloaded.
- Direct link to the `.deb` package (for example, on the developer's website)
- The link to the archive with binary files (compiled app or installer)
- The link to `AppImange`


To download programs with all dependencies, you need to run this script on a freshly installed system that hasn't been updated with packages or installed any programs yet.
Only in this way will you get programs with all the libraries that can be installed offline.


Edit the list of programs you need in this script and run it. The script will prompt you to download  packages or install already downloaded ones. There is also an interactive wizard that will help you properly download packages with all the necessary dependencies using a fresh system in a virtual machine.

**To have a repeatable result in the form of packages that can be installed offline on any system,always download from apt repositories only on fresh installed Linux to include all the necessary dependencies!**

You can use environment variables to make the script more subtle. All variables are listed in the comments at the top of the script.
