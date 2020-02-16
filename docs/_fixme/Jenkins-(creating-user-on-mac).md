# __ TODO Experimental __

Create (using `id` command check new user's `UniqueID` is really unique):
```bash
sudo dscl . -create /Users/jenkins-bot
sudo dscl . -create /Users/jenkins-bot UserShell /bin/bash
sudo dscl . -create /Users/jenkins-bot RealName "Jenkins Bot"
sudo dscl . -create /Users/jenkins-bot UniqueID "1010"
sudo dscl . -create /Users/jenkins-bot PrimaryGroupID 508
sudo dscl . -create /Users/jenkins-bot NFSHomeDirectory /Users/jenkins-bot
```

Create password:
```bash
sudo passwd jenkins-bot
```

Verify created `id`:
```bash
id jenkins-bot
```

Create user directory:
```bash
sudo mkdir /Users/jenkins-bot
sudo chown -R jenkins-bot:508 /Users/jenkins-bot
```

Test it:
```bash
su jenkins-bot
sudo ls
# Expected error: `jenkins-bot is not in the sudoers file`
cat /Users/anotheruser/.ssh/id_rsa
# Expected error: `Permission denied`
chmod 777 /Users/anotheruser/.ssh/id_rsa
# Expected error: `Permission denied`
which python
# OK
python
# OK
```
