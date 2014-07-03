import sys
import subprocess

def get_environment_from_batch_command(env_cmd, initial=None):
    """
    Take a command (either a single command or list of arguments)
    and return the environment created after running that command.
    Note that if the command must be a batch file or .cmd file, or the
    changes to the environment will not be captured.

    If initial is supplied, it is used as the initial environment passed
    to the child process.
    """
    if not isinstance(env_cmd, (list, tuple)):
        env_cmd = [env_cmd]
    # construct the command that will alter the environment
    env_cmd = subprocess.list2cmdline(env_cmd)
    # create a tag so we can tell in the output when the proc is done
    tag = 'Done running command'
    # construct a cmd.exe command to do accomplish this
    cmd = 'cmd.exe /s /c "{env_cmd} && echo "{tag}" && set"'.format(**vars())
    # launch the process
    output = subprocess.check_output(cmd, universal_newlines=True)
    list_of_output = output.split('\n')
    result = dict()
    is_environment = False
    for i in list_of_output:
      if not is_environment:
        if i == '"{}" '.format(tag):
          is_environment = True
        continue
      if not i:
        continue
      eq_index = i.find('=')
      if eq_index == -1:
        sys.exit('Expected `=`')
      var_name = i[0:eq_index]
      var_value = i[eq_index + 1:]
      result[var_name] = var_value
    return result
