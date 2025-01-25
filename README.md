# Git Repository URL Opener

This Bash script allows you to quickly open the remote URL of a Git repository in your default web browser. It's useful for developers who frequently need to access the web interface of their Git repositories (e.g., GitHub, GitLab, Bitbucket).

> Built partly with the help of [T3 Chat](https://t3.chat) and [Duck.ai](https://duck.ai)

## Features

- Opens the remote URL of a Git repository in your default web browser
- Works with both HTTPS and SSH remote URLs
- Can be run from any directory within a Git repository
- Allows specifying a different Git repository directory
- Option to only print the URL without opening the browser

## Prerequisites

- Git installed and accessible from the command line
- A default web browser (the script uses `xdg-open` on Linux/Mac and `start` on Windows)

## Installation

- Bash:

```bash
sudo curl https://raw.githubusercontent.com/Souvlaki42/git-repo-opener/master/git-open.sh -o /usr/local/bin/git-open
sudo chmod +x /usr/local/bin/git-open
git config --global alias.open "!git-open"
```

- Powershell:

```powershell
curl https://raw.githubusercontent.com/Souvlaki42/git-repo-opener/master/git-open.ps1 -o $HOME/git-open.ps1
git config --global alias.open "!powershell -c ~/git-open.ps1"
Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy  RemoteSigned
```

- Nushell:

```nushell
curl https://raw.githubusercontent.com/Souvlaki42/git-repo-opener/master/git-open.nu -o ~/git-open.nu
git config --global alias.open "!nu ~/git-open.nu"
```

## Usage

### Basic Usage

Run the script from within a Git repository:

```
git open
```

This will open the remote URL of the current Git repository in your default web browser.

### Command-line Options

- `-h` or `--help`: Display the help message
- `-d <path>` or `--directory <path>`: Specify a different Git repository directory
- `-p` or `--print`: Only print the URL, don't open in the browser

### Examples

1. Open the remote URL of the current directory's Git repository:

   ```
   git open
   ```

2. Open the remote URL of a specific Git repository:

   ```
   git open -d /path/to/your/repo
   ```

3. Only print the remote URL without opening it:

   ```
   git open -p
   ```

4. Print the remote URL of a specific repository:
   ```
   git open -d /path/to/your/repo -p
   ```

## Contributing

Contributions to improve the script are welcome! Please feel free to submit issues or pull requests on the project's repository.

## License

This script is released under the MIT License. See the [LICENSE](LICENSE) file for details.

