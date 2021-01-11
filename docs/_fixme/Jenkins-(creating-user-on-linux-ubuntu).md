Create new user:
```bash
sudo useradd --home-dir /home/jenkins-bot --create-home --shell /bin/bash jenkins-bot
```

Create password:
```bash
sudo passwd jenkins-bot
```

Test it:
```
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