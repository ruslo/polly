# Installation on Jenkins CI
* [Jenkins](http://jenkins-ci.org/)

### Plugins
* [Git Plugin](https://wiki.jenkins-ci.org/display/JENKINS/Git+Plugin)
* [GitHub](https://wiki.jenkins-ci.org/display/JENKINS/GitHub+Plugin)
* [Matrix Project Plugin](https://wiki.jenkins-ci.org/display/JENKINS/Matrix+Project+Plugin)
* [Matrix Reloaded](https://wiki.jenkins-ci.org/display/JENKINS/Matrix+Reloaded+Plugin)
* [Conditional BuildStep Plugin](https://wiki.jenkins-ci.org/display/JENKINS/Conditional+BuildStep+Plugin)
* [Build Name Setter Plugin](https://wiki.jenkins-ci.org/display/JENKINS/Build+Name+Setter+Plugin)
* [Email-ext plugin](https://wiki.jenkins-ci.org/display/JENKINS/Email-ext+plugin)
* [Green Balls](https://wiki.jenkins-ci.org/display/JENKINS/Green+Balls)
* [pre-scm-buildstep](https://wiki.jenkins-ci.org/display/JENKINS/pre-scm-buildstep)

### Project
* Open URL `http://yourjenkins/server` and choose `New Item`:

![new item][new-item]

* Then `Build multi-configuration project`:

![multi configuration project][multi-configuration-project]

* Enter the path to your repo in `Source Code Management` section and other parameters you need.
* Add `Clean before checkout` in `Additional Behaviours` to remove temporary directories created by CMake's previous build:

![clean before checkout][clean-before-checkout]

* Choose when to start a build in `Build Triggers` section. For example to poll every minute (or
something less often like once a day `H H * * *` if you're using hooks):

![build triggers][build-triggers]

* In `Configuration Matrix` section add `Slaves` axis:

![configuration matrix add slaves axis][configuration-matrix-add-slaves-axis]

and slaves' labels to build. E.g. if every slave marked with `linux`, `mac` or `windows` label: 

![configuration matrix labels](https://cloud.githubusercontent.com/assets/4346993/13377330/f461d65a-de08-11e5-8fc6-18a503421774.png)

* Add user-defined axis `TOOLCHAIN` and pick toolchains you're interested in:

![user defined axis](https://cloud.githubusercontent.com/assets/4346993/13377293/166d8d54-de07-11e5-8b8f-843d79ccfc1b.png)

![toolchain list](https://cloud.githubusercontent.com/assets/4346993/13377342/91a94c4a-de09-11e5-8d69-52c0b78ad356.png)

* List of toolchains (alphabetically):
```
analyze
clang-libstdcxx
clang-lto
cygwin
default
gcc
ios-7-0
ios-7-1
ios-8-0
ios-8-1
libcxx
mingw
msys
nmake-vs-12-2013
nmake-vs-12-2013-win64
sanitize-address
sanitize-leak
sanitize-memory
sanitize-thread
vs-12-2013
vs-12-2013-xp
vs-12-2013-win64
xcode
```

* and a `CONFIG` axis, like `Debug`/`Release`:

![config axis](https://cloud.githubusercontent.com/assets/4346993/13377208/3063b88a-de04-11e5-824e-be6dc09b04df.png)

* since not every toolchain is available for every platfrom some filtering needed here.
Filter expression for `linux`, `mac`, `windows` and toolchains:
```
(
    label=="mac" && (
        TOOLCHAIN=="analyze" ||
        TOOLCHAIN=="clang-lto" ||
        TOOLCHAIN=="clang-libstdcxx" ||
        TOOLCHAIN=="default" ||
        TOOLCHAIN=="gcc" ||
        TOOLCHAIN=="ios-7-0" ||
        TOOLCHAIN=="ios-7-1" ||
        TOOLCHAIN=="ios-8-0" ||
        TOOLCHAIN=="ios-8-1" ||
        TOOLCHAIN=="libcxx" ||
        TOOLCHAIN=="sanitize-address" ||
        TOOLCHAIN=="xcode"
    )
)
||
(
    label=="linux" && (
        TOOLCHAIN=="analyze" ||
        TOOLCHAIN=="clang-libstdcxx" ||
        TOOLCHAIN=="default" ||
        TOOLCHAIN=="gcc" ||
        TOOLCHAIN=="sanitize-address" ||
        TOOLCHAIN=="sanitize-leak" ||
        TOOLCHAIN=="sanitize-memory" ||
        TOOLCHAIN=="sanitize-thread"
    )
)
||
(
    label=="windows" && (
        TOOLCHAIN=="default" ||
        TOOLCHAIN=="mingw" ||
        TOOLCHAIN=="msys" ||
        TOOLCHAIN=="nmake-vs-12-2013" ||
        TOOLCHAIN=="nmake-vs-12-2013-win64" ||
        TOOLCHAIN=="vs-12-2013" ||
        TOOLCHAIN=="vs-12-2013-xp" ||
        TOOLCHAIN=="vs-12-2013-win64"
    )
)
||
(
    label=="cygwin" && (
        TOOLCHAIN=="cygwin" ||
        TOOLCHAIN=="default"
    )
)
```

![combination filter](https://cloud.githubusercontent.com/assets/4346993/13377207/3060e056-de04-11e5-9a25-1f07a2621367.png)

### Build Environment

To view the git branch name and first 6 letters of SHA1 add `Build Name`:

```
#${BUILD_NUMBER} (${GIT_BRANCH} - ${GIT_REVISION, length=6})
```

![set build name](https://cloud.githubusercontent.com/assets/4346993/13377316/4acb2f42-de08-11e5-8582-83528febaee4.png)

### Conditional Build Step

Every platform has it's own build step (this step is not `Execute python script` since `python3` need to be used instead of default `python`). Use `Execute shell` for Linux/Mac/Cygwin:
```bash
build.py --toolchain ${TOOLCHAIN} --config ${CONFIG} --verbose --clear --test
```

and `Execute windows batch command` for Windows:

```bash
build.py --toolchain %TOOLCHAIN% --config %CONFIG% --verbose --clear --test
```

![execute-python-script](https://cloud.githubusercontent.com/assets/4346993/13377211/3083401a-de04-11e5-90e4-8fbd146a2594.png)

*Notes*:
* Add `/path/to/polly/directory/bin` to the PATH environment variable of the slave (`Jenkins` -> `nodes` -> `<Slave name>` -> `Configure` -> `Node properties` -> `Environment variables`)
* Used `Conditional BuildStep` plugin

### Result

* If you do everything carefully after the build done you must see something similar to:

![matrix result](https://cloud.githubusercontent.com/assets/4346993/13377324/9f3a396a-de08-11e5-9ec1-ee7159a29af0.png)

### Next

* [Build bot (PR)](https://github.com/ruslo/polly/wiki/Jenkins-%28build-bot,-PR%29)
* [Build bot (integration)](https://github.com/ruslo/polly/wiki/Jenkins-%28build-bot,-integration%29)
* [Pitfalls](https://github.com/ruslo/hunter/wiki/Jenkins-%28pitfalls%29)
* [Jenkins with Hunter package manager](https://github.com/ruslo/hunter/wiki/Jenkins)

### Other

* CMake install:
```
build.py --install --toolchain default --config Release --verbose --fwd "CMAKE_USE_SYSTEM_CURL=YES"
```
* [Creating user on mac](https://github.com/ruslo/polly/wiki/Jenkins-%28creating-user-on-mac%29)
* [Creating user on linux](https://github.com/ruslo/polly/wiki/Jenkins-%28creating-user-on-linux-ubuntu%29)
* [Install java on ubuntu](https://www.digitalocean.com/community/tutorials/how-to-install-java-on-ubuntu-with-apt-get)
* [Alternative windows slave install](https://wiki.jenkins-ci.org/display/JENKINS/Launch+Java+Web+Start+slave+agent+via+Windows+Scheduler)
* [Debug ssh connect on cygwin](https://cygwin.com/ml/cygwin/2012-08/msg00551.html)

#### OS X
* [Start sshd on mac](http://superuser.com/questions/104929/how-do-you-run-a-ssh-server-on-mac-os-x)
* [Change sshd port on mac](http://serverfault.com/questions/18761/how-to-change-sshd-port-on-mac-os-x)
* [Configure sshd on mac](http://superuser.com/questions/364304/how-do-i-configure-ssh-on-os-x)
* [SSH: do not forget UsePAM](http://apple.stackexchange.com/questions/34090)
* [Java install on mac](http://stackoverflow.com/questions/19533528/installing-java-on-os-x-10-9-mavericks)
* [Start service on mac](http://stackoverflow.com/a/13372744/2288008)

[new-item]: https://cloud.githubusercontent.com/assets/4346993/13377214/3089a9fa-de04-11e5-83c6-02efa17ac82e.png
[multi-configuration-project]: https://cloud.githubusercontent.com/assets/4346993/13377202/2fb6a17c-de04-11e5-9e55-44c4e12bb684.png
[clean-before-checkout]: https://cloud.githubusercontent.com/assets/4346993/13377206/305db1ce-de04-11e5-85ea-de63dc22f412.png
[build-triggers]: https://cloud.githubusercontent.com/assets/4346993/13377203/2fea3230-de04-11e5-9e89-52fbd9495f29.png
[configuration-matrix-add-slaves-axis]: https://cloud.githubusercontent.com/assets/4346993/13377210/3067fe40-de04-11e5-9c20-980ad1e930f3.png