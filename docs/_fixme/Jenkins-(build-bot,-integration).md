### Automatically merge to master (blessed) branch

* [Git plugin](https://wiki.jenkins-ci.org/display/JENKINS/Git+Plugin)

This manual is about creation a job that will merge some branch (e.g. `develop`) to other branch (e.g. `master`) after ci testing successfully finished => branch `master` will always be in good condition (aka `blessed`).

* In `Source Code Management` set url of git repository. Note that `Credentials` is necessary since
you need to push code to upstream repo
* Set `Branches to build` to `*/develop`
* Select `Add` -> `Merge before build`
* Set `Name of repository` to `origin`
* Set `Branch to merge to` to `master`
* In `Add post-build actions` pick a `Git Publisher`
* Set checkboxes `Push Only If Build Succeeds` and `Merge Results`