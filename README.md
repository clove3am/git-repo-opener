# Git Repository URL Opener

> [!NOTE]  
> This branch is now abandoned. Use the [new version](https://github.com/Souvlaki42/git-repo-opener/tree/main) instead if you like.

These scripts allow you to quickly open the remote URL of a Git repository in your default web browser. It's useful for developers who frequently need to access the web interface of their Git repositories (e.g., GitHub, GitLab, Bitbucket).

Inspired by [clove3am](https://github.com/clove3am/git-repo-opener).

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
curl https://raw.githubusercontent.com/Souvlaki42/git-repo-opener/shell/git-open.sh -o ~/git-open.sh
chmod +x ~/git-open.sh
git config --global alias.open "!sh ~/git-open.sh"
```

- Powershell:

```powershell
curl https://raw.githubusercontent.com/Souvlaki42/git-repo-opener/shell/git-open.ps1 -o $HOME/git-open.ps1
git config --global alias.open "!powershell -c ~/git-open.ps1"
Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy  RemoteSigned
```

- Nushell:

```nushell
curl https://raw.githubusercontent.com/Souvlaki42/git-repo-opener/shell/git-open.nu -o ~/git-open.nu
git config --global alias.open "!nu ~/git-open.nu"
```

## Uninstallation

```nushell
rm -rf ~/git-open.sh # For bash
Remove-Item -Recurse -Force ~/git-open.ps1 # For powershell
rm -rf ~/git-open.nu # for Nushell

git config --global --unset alias.open # For all of them
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

