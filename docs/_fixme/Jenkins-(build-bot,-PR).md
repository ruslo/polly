### Job for testing github pull requests on demand

#### Plugin

* [GitHub pull request builder](https://wiki.jenkins-ci.org/display/JENKINS/GitHub+pull+request+builder+plugin)

#### Global config

* Create separate account for build bot and generate token using jenkins:
`Jenkins` -> `Manage Jenkins` -> `Configure System` -> `GitHub Pull Request Builder`
* Fill `username` and `password` and hit `Create access token`
* Fill `Access Token` with generated value
* Fill `Admin list` with the users which are able to control bot
* `Request for testing phrase` phrase which bot will send if he detect new pull request and user is not white-listed to run the job automatically
* `Test phrase` if this phrase said by admin build bot will start testing pull request
* `Crontab line` polling schedule (if updated by polling)

#### Job config

* `Jenkins` -> `Name of the project` -> `Configure`
* Fill `GitHub project`
* `Source Code Management` -> `Git`, Fill `Repository URL`
* `Advanced` -> `Refspec` set to `+refs/pull/*:refs/remotes/origin/pr/*`
* Leave `Branches to build` blanked
* In `Build Triggers` set checkbox `GitHub Pull Request Builder` and fill fields `Admin list` and `Crontab line` (note: do not set any other build triggers!)
* In `Post-build Actions` add action `Set build status on GitHub commit`

#### Testing
* Note that your build bot must have enough permissions (like project collaborator)
* Now send pull request to repo
* Wait for timeout you've set (if you choose polling), the message that you specified in `Request for testing phrase` must be send by bot
* Note that no builds must be triggered at this time!
* Review pull request and send request for testing by sending message from the `Test phrase` field
* Check that the build triggered
* Check that result of the build appears in commit, like: `Success: Merged build finished`

#### Debug

If something went wrong or some unexpected behaviour happens check the jenkins log: `Jenkins` -> `Manage Jenkins` -> `System Log`