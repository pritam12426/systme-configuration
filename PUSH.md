# File Sync Python Script

This Python script allows you to generate checksums for two files and synchronize the local file with the file present inside a Git repository if any changes are detected. The synchronization details are provided in a YAML configuration file. The script will use the checksums to determine if the files need to be synced.

## Requirements

- Python 3.x
- PyYAML library (`pip install pyyaml`)
- gitpython library (`pip install gitpython`)

## Usage

1. Ensure you have Python 3.x installed on your system.
2. Install the PyYAML library by running `pip install pyyaml`.
3. Install the gitpython library by running `pip install gitpython`.
4. Prepare the YAML configuration file with details about the files and their synchronization paths.

## YAML Configuration

The YAML configuration file should have the following structure and name `file_path.yaml`:

```yaml
# Local git repo path in which you wants to sync your files.
# Example: Syncing files to the 'my_config' repository on GitHub
git_dir: "/home/pritam/Desktop/programming/git_repositories/my_config/"

# Single file path with some keys.
".bashrc":
    # The folder path where the original file is located.
    # Example: The '.bashrc' file is located in the '/home/pritam/' directory.
    "sys_dir": "/home/pritam/"

    # The folder path inside the local git repo where you want to sync the file.
    # Example: The '.bashrc' file will be synced to the 'linux_ubuntu/' folder.
    "gdir": "linux_ubuntu/"

    # The new name for the file inside the git repo.
    # Example: The '.bashrc' file will be renamed to 'bashrc.sh' in the git repo.
    "new_name": "bashrc.sh"
```

## Running the Script

1. Save the YAML configuration file with the desired details of file synchronization.
2. Save this Python script as `push_config_to_github.py`.
3. Open a terminal or command prompt and navigate to the directory containing both the script and the YAML configuration file.
4. Run the following command to execute the script:

```bash
python push_config_to_github.py
```

## Important Note

- Before running the script, ensure that you have initialized the local git repository (`git init`) and added the necessary remote repository using `git remote add origin <repository_url>`.

- The script will compare the checksums of the local and remote files. If there are any changes, it will automatically sync the local file with the file present inside the specified Git repository.

- Be cautious while using this script, as it will make changes to the files in the local repository and potentially overwrite remote files. Always review the changes before committing to the remote repository.

## Disclaimer

This script comes with no warranties or guarantees. Use it at your own risk. It is always recommended to have backups of your files and repositories before running any synchronization scripts.
